#!/bin/bash

# Ensure execution permissions for the script
chmod +x "$0"

# Store the list of installed gems before installation
before_install=$(gem list --local | cut -d" " -f1)

# Check if the xcodeproj is installed, if not install it
if ! gem list -i xcodeproj > /dev/null 2>&1; then
    echo "Installing xcodeproj..."
    gem install xcodeproj --user-install
    XCODEPROJ_INSTALLED=true
else
    echo "xcodeproj gem is already installed."
fi

# Store the list of installed gems after installation
after_install=$(gem list --local | cut -d" " -f1)

# Find the newly installed gems
newly_installed=$(comm -13 <(echo "$before_install" | sort) <(echo "$after_install" | sort))

# Get new app name from user
echo -e "\033[31mEnter the new app name: \033[0m\c"
read NEW_APP_NAME
if [ -z "$NEW_APP_NAME" ]; then
    echo "Error: New app name cannot be empty."
    exit 1
fi

OLD_APP_NAME="SwiftAppTemplate"
DESTINATION_PATH="$HOME/Desktop/$NEW_APP_NAME"
# Release tag to clone
RELEASE_TAG="v0.0.1"

# Create the destination directory if it doesn't exist
mkdir -p "$DESTINATION_PATH"

# Clone the template project at a specific release tag into the destination directory
git clone --branch "$RELEASE_TAG" --depth 1 https://github.com/shurutech/iOSKickstart.git "$DESTINATION_PATH"

# Navigate to the cloned directory
cd "$DESTINATION_PATH" || exit

# Rename the .xcodeproj directory
mv "$OLD_APP_NAME.xcodeproj" "$NEW_APP_NAME.xcodeproj"

# Rename the main project folder containing Swift files and views
mv "$OLD_APP_NAME" "$NEW_APP_NAME"

# Check if .git directory exists and remove it
if [ -d ".git" ]; then
    rm -rf .git
    echo "Unlinked project from Git repository."
else
    echo "Project is not linked to a Git repository."
fi

function delete_lines() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: delete_lines <file_path> <line_numbers>"
        return 1
    fi

    file_path="$1"
    shift
    line_numbers=("$@")

    if [ ! -f "$file_path" ]; then
        echo "Error: File not found - $file_path"
        return 1
    fi

    sed_args=""
    for arg in "${line_numbers[@]}"; do
        if [[ "$arg" == *-* ]]; then
            # Handle ranges
            start=$(echo "$arg" | cut -d'-' -f1)
            end=$(echo "$arg" | cut -d'-' -f2)
            sed_args="${sed_args}${start},${end}d; "
        else
            # Individual line numbers
            sed_args="${sed_args}${arg}d; "
        fi
    done

    sed_args="${sed_args%??}"  # Remove the trailing "; "

    sed -i.bak "$sed_args" "$file_path"
    echo "Lines ${line_numbers[*]} deleted from $file_path"
}



# Define the paths to your configuration files
DEBUG_CONFIG_FILE="$DESTINATION_PATH/$NEW_APP_NAME/Configuration/Debug.xcconfig"
RELEASE_CONFIG_FILE="$DESTINATION_PATH/$NEW_APP_NAME/Configuration/Release.xcconfig"

# Define the new values for APP_NAME and APP_BUNDLE_ID
NEW_APP_BUNDLE_ID="com.example.$NEW_APP_NAME"
OLD_BUNDLE_ID="com.shurutech.$OLD_APP_NAME"

# Update APP_NAME and APP_BUNDLE_ID in the Debug Configuration
sed -i '' "s/$OLD_BUNDLE_ID"Debug"/$NEW_APP_BUNDLE_ID"Debug"/g" "$DEBUG_CONFIG_FILE"
sed -i '' "s/$OLD_APP_NAME Debug/$NEW_APP_NAME Debug/g" "$DEBUG_CONFIG_FILE"

# Update APP_NAME and APP_BUNDLE_ID in the Release Configuration
sed -i '' "s/$OLD_BUNDLE_ID/$NEW_APP_BUNDLE_ID/g" "$RELEASE_CONFIG_FILE"
sed -i '' "s/$OLD_APP_NAME/$NEW_APP_NAME/g" "$RELEASE_CONFIG_FILE"

# Ask the user to include the side menu or not
echo -e "\033[31mDo you require a side menu? (Yn): \033[0m\c"
read REQUIRE_SIDE_MENU
REMOVE_SIDE_MENU=false

if [ "$REQUIRE_SIDE_MENU" = "n" ] || [ "$REQUIRE_SIDE_MENU" = "N" ]; then
    REMOVE_SIDE_MENU=true
    pathOfSideMenuFolder="$DESTINATION_PATH/$NEW_APP_NAME/Screens/SideMenu"
    
    echo "Removing folder: $pathOfSideMenuFolder"
    rm -rf "$pathOfSideMenuFolder"
    
    pathToMainCoordinator="$DESTINATION_PATH/$NEW_APP_NAME/Screens/MainTabView/MainTabCoordinator.swift"

    
    # Check and update permissions
    if [ ! -r "$pathToMainCoordinator" ]; then
        chmod +r "$pathToMainCoordinator"
    fi
    
    #Removing from MainTabCoordinator
    delete_lines "$pathToMainCoordinator" 12 19 24-28 44-60
    
elif [ "$REQUIRE_SIDE_MENU" = "y" ] || [ "$REQUIRE_SIDE_MENU" = "Y" ]; then
    echo "Side menu will be added."
else
    echo "Incorrect input given."
fi

# Ask user to enter number of tabs required in app
echo -e "\033[31mEnter the number of tabs between 2 to 5: \033[0m\c"
read NUM_TABS

if [ "$NUM_TABS" -ge 2 ] && [ "$NUM_TABS" -le 5 ]; then
    echo "Continuing with $NUM_TABS tabs."
else
    echo "Invalid number of tabs. Please enter a number between 2 and 5."
    exit 1
fi

declare -a TAB_TITLES
declare -a TAB_ICONS

for ((i=1; i<=NUM_TABS; i++)); do
    TAB_TITLES[$i]="Tab$i"
    TAB_ICONS[$i]="$i.circle.fill"
done

TAB_ENUM_CODE="enum Tab: CaseIterable{"
TAB_VIEW_CODE="TabView(selection: \$viewModel.selectedTab, content:  {"

for ((i=1; i<=NUM_TABS; i++)); do
    title=${TAB_TITLES[$i]}
    icon=${TAB_ICONS[$i]}
    viewName="${title}Screen()"
    TAB_ENUM_CODE+="
      case $(echo $title | awk '{print tolower($0)}')"
    TAB_VIEW_CODE+="
    $viewName.tabItem { TabItem(title: \"$title\", icon: \"$icon\") }.tag(Tab.$(echo $title | awk '{print tolower($0)}'))"
done

TAB_VIEW_CODE+="
})"
TAB_ENUM_CODE+="
}"

SWIFT_FILE_PATH="$DESTINATION_PATH/$NEW_APP_NAME/Screens/MainTabView/MainTabCoordinator.swift"
SWIFT_VIEW_MODEL_FILE_PATH="$DESTINATION_PATH/$NEW_APP_NAME/Screens/MainTabView/ViewModels/MainTabViewModel.swift"

# Write the new tab view code to a temporary file
echo "$TAB_VIEW_CODE" > tab_view_temp.txt
echo "$TAB_ENUM_CODE" > tab_enum_temp.txt

# Find the start line of the old TabView code
START_LINE=$(grep -n "TabView(selection: \$viewModel.selectedTab," "$SWIFT_FILE_PATH" | head -1 | cut -d: -f1)
START_LINE_ENUM=$(grep -n "enum Tab: CaseIterable{" "$SWIFT_VIEW_MODEL_FILE_PATH" | head -1 | cut -d: -f1)


# Find the end line of the old TabView code, looking for the line with '})'
END_LINE=$(awk -v start="$START_LINE" 'NR > start && /}\)/ {print NR; exit}' "$SWIFT_FILE_PATH")
END_LINE_ENUM=$(awk -v start="$START_LINE_ENUM" 'NR > start && /}/ {print NR; exit}' "$SWIFT_VIEW_MODEL_FILE_PATH")


# Delete the old TabView section
sed -i '' "${START_LINE},${END_LINE}d" "$SWIFT_FILE_PATH"
sed -i '' "${START_LINE_ENUM},${END_LINE_ENUM}d" "$SWIFT_VIEW_MODEL_FILE_PATH"

# Insert the new TabView code before the original start line
awk -v line="$START_LINE" -v file="tab_view_temp.txt" 'NR==line{system("cat " file)} {print}' "$SWIFT_FILE_PATH" > temp.swift && mv temp.swift "$SWIFT_FILE_PATH"
awk -v line="$START_LINE_ENUM" -v file="tab_enum_temp.txt" 'NR==line{system("cat " file)} {print}' "$SWIFT_VIEW_MODEL_FILE_PATH" > temp.swift && mv temp.swift "$SWIFT_VIEW_MODEL_FILE_PATH"

# Remove the temporary file
rm tab_view_temp.txt
rm tab_enum_temp.txt

for ((i=5; i>NUM_TABS; i--)); do
    rm -f "$DESTINATION_PATH/$NEW_APP_NAME/Screens/MainTabView/TabViews/Tab${i}Screen.swift"
done




# Ask the user to include the tnc screen or not
echo -e "\033[31mDo you require a terms and condition screen? (Yn): \033[0m\c"
read REQUIRE_TNC_SCREEN
REMOVE_TNC_SCREEN=false

if [ "$REQUIRE_TNC_SCREEN" = "n" ] || [ "$REQUIRE_TNC_SCREEN" = "N" ]; then
    REMOVE_TNC_SCREEN=true
    pathOfTncFolder="$DESTINATION_PATH/$NEW_APP_NAME/Screens/TermsAndConditions"
    
    echo "Removing folder: $pathOfTncFolder"
    rm -rf "$pathOfTncFolder"
    
    pathToRootCoordinator="$DESTINATION_PATH/$NEW_APP_NAME/Screens/Root/RootCoordinator.swift"
    pathToRootViewModel="$DESTINATION_PATH/$NEW_APP_NAME/Screens/Root/RootViewModel.swift"
    pathToOnBoardingScreen="$DESTINATION_PATH/$NEW_APP_NAME/Screens/Onboarding/OnboardingScreen.swift"

    
    # Check and update permissions
    if [ ! -r "$pathToRootCoordinator" ] || [ ! -r "$pathToRootViewModel" ] || [ ! -r "$pathToOnBoardingScreen" ]; then
#        echo "Adding read permissions to $pathToMainCoordinator"
        chmod +r "$pathToRootCoordinator"
        chmod +r "$pathToRootViewModel"
        chmod +r "$pathToOnBoardingScreen"
    fi
    
    #Removing from root coordinator
    delete_lines "$pathToRootCoordinator" 15 41-42 45 54 82-84
    
    #Removing from RootViewModel
    delete_lines "$pathToRootViewModel" 17 35 46-51
    
    #Removing from OnBoardingScreen
    delete_lines "$pathToOnBoardingScreen" 30-33

elif [ "$REQUIRE_TNC_SCREEN" = "y" ] || [ "$REQUIRE_TNC_SCREEN" = "Y" ]; then
    echo "Terms and conditions screen will be added."
else
    echo "Incorrect input given."
fi


# Ask the user to include the onboarding screen or not
echo -e "\033[31mDo you require an onboarding screen? (Yn): \033[0m\c"
read REQUIRE_ONBOARDING_SCREEN
REMOVE_ONBOARDING_SCREEN=false

if [ "$REQUIRE_ONBOARDING_SCREEN" = "n" ] || [ "$REQUIRE_ONBOARDING_SCREEN" = "N" ]; then
    REMOVE_ONBOARDING_SCREEN=true
    pathOfOnboardingFolder="$DESTINATION_PATH/$NEW_APP_NAME/Screens/Onboarding"
    
    echo "Removing folder: $pathOfOnboardingFolder"
    rm -rf "$pathOfOnboardingFolder"
    
    pathToRootCoordinator="$DESTINATION_PATH/$NEW_APP_NAME/Screens/Root/RootCoordinator.swift"
    pathToRootViewModel="$DESTINATION_PATH/$NEW_APP_NAME/Screens/Root/RootViewModel.swift"
    
    # Check and update permissions
    if [ ! -r "$pathToRootCoordinator" ] || [ ! -r "$pathToRootViewModel" ]; then
#        echo "Adding read permissions to $pathToMainCoordinator"
        chmod +r "$pathToRootCoordinator"
        chmod +r "$pathToRootViewModel"
    fi
    
    #Removing from rootCoordinator
    if $REMOVE_TNC_SCREEN; then
        delete_lines "$pathToRootCoordinator" 15 40-42 50 77-79
    else
        delete_lines "$pathToRootCoordinator" 16 43-46 55 85-87
    fi
    
    #Removing from RootViewModel
    if $REMOVE_TNC_SCREEN; then
        delete_lines "$pathToRootViewModel" 17 34 45-50
    else
        delete_lines "$pathToRootViewModel" 18 36 53-58
    fi
    

elif [ "$REQUIRE_ONBOARDING_SCREEN" = "y" ] || [ "$REQUIRE_ONBOARDING_SCREEN" = "Y" ]; then
    echo "Onboarding screen will be added."
else
    echo "Incorrect input given."
fi



# Execute Ruby script
ruby << RUBY_SCRIPT
require 'xcodeproj'

old_project_name = "$OLD_APP_NAME"
new_project_name = "$NEW_APP_NAME"
remove_side_menu = $REMOVE_SIDE_MENU
remove_tnc_screen = $REMOVE_TNC_SCREEN
remove_onboarding_screen = $REMOVE_ONBOARDING_SCREEN
num_tab = $NUM_TABS
project_path = "#{Dir.pwd}/#{new_project_name}.xcodeproj"

project = Xcodeproj::Project.open(project_path)

def rename_group(group, old_name, new_name)
  group.children.each do |child|
    if child.is_a?(Xcodeproj::Project::Object::PBXGroup) && child.path == old_name
      puts "Renaming group from '#{old_name}' to '#{new_name}'"
      child.path = new_name
      break
    end
  end
end


def remove_folder(group, folder_name)
  group.children.dup.each do |child|
    if child.is_a?(Xcodeproj::Project::Object::PBXGroup)
      if child.path == folder_name
        child.remove_from_project
        return true
      else
        removed = remove_folder(child, folder_name)
        return true if removed
      end
    end
  end
  false
end

def remove_group(group, target, file_names = nil, group_name = nil, file_in_group = nil)
  group.children.dup.each do |child|
    if child.is_a?(Xcodeproj::Project::Object::PBXGroup)
      if group_name && child.name == group_name
        child.children.each do |inner_child|
          if inner_child.is_a?(Xcodeproj::Project::Object::PBXFileReference) && (file_in_group.nil? || inner_child.path == file_in_group)
            target.source_build_phase.remove_file_reference(inner_child)
            inner_child.remove_from_project
          end
        end
        group.remove_child(child) unless file_in_group
      else
        remove_group(child, target, file_names, group_name, file_in_group)
      end
    elsif child.is_a?(Xcodeproj::Project::Object::PBXFileReference) && file_names&.include?(File.basename(child.real_path.to_s))
      target.source_build_phase.remove_file_reference(child)
      child.remove_from_project
    end
  end
end

# Update target and product names
project.targets.each do |target|
  puts "Old target name: #{target.name}"
  target.name = new_project_name
  puts "New target name: #{target.name}"

  target.build_configurations.each do |config|
    puts "Old product name: #{config.build_settings['PRODUCT_NAME']}"
    config.build_settings['PRODUCT_NAME'] = new_project_name
    puts "New product name: #{config.build_settings['PRODUCT_NAME']}"

    # Update productName to new project name
    if config.build_settings.key?('PRODUCT_NAME')
      config.build_settings['PRODUCT_NAME'] = new_project_name
    end
  end
  
  target.source_build_phase.files_references.each do |file_ref|
    if file_ref.path == 'SideMenuView.swift' && remove_side_menu == true
      target.source_build_phase.remove_file_reference(file_ref)
    end
    if file_ref.path == 'TermsAndConditionsScreen.swift' && remove_tnc_screen == true
      target.source_build_phase.remove_file_reference(file_ref)
    end
    if file_ref.path == 'OnboardingScreen.swift' && remove_onboarding_screen == true
      target.source_build_phase.remove_file_reference(file_ref)
    end
    
    (5).downto(num_tab+1).each do |i|
      if file_ref.path == "Tab#{i}Screen.swift"
        target.source_build_phase.remove_file_reference(file_ref)
      end
    end
  end
end

## TabScreen names that should be removed
file_names_to_remove = (num_tab+1..5).map { |i| "Tab#{i}Screen.swift" }

project.targets.each do |target|
  project.main_group.children.each do |child|
    if child.is_a?(Xcodeproj::Project::Object::PBXGroup)
      remove_group(child, target, file_names_to_remove)
      if remove_side_menu == true
        remove_group(child, target, "SideMenuView.swift")
      end
      if remove_tnc_screen == true
        remove_group(child, target, "TermsAndConditionsScreen.swift")
      end
      if remove_onboarding_screen == true
        remove_group(child, target, "OnboardingScreen.swift")
      end
    end
  end
end

if remove_side_menu == true
  remove_folder(project.main_group, "SideMenu")
end
if remove_tnc_screen == true
  remove_folder(project.main_group, "TermsAndConditions")
end
if remove_onboarding_screen == true
  remove_folder(project.main_group, "Onboarding")
end

# Rename a specific group (change 'SpecificGroupName' to the name of the group you want to rename)
rename_group(project.main_group, old_project_name, new_project_name)

# Update the file references inside the project
project.files.each do |file|
  file.path = file.path.gsub(old_project_name, new_project_name) if file.path.include?(old_project_name)
end

# Fetch the new target
new_target = project.targets.find { |t| t.name == new_project_name }
unless new_target
  puts "New target '#{new_project_name}' not found."
  exit 1
end

# Update scheme names and their Buildable References
schemes_path = "#{project_path}/xcshareddata/xcschemes"
Dir.glob("#{schemes_path}/*.xcscheme").each do |scheme_path|
  scheme = Xcodeproj::XCScheme.new(scheme_path)

  # Update Buildable References for actions that have buildable_product_runnable
  [scheme.launch_action, scheme.profile_action].each do |action|
    if action && action.respond_to?(:buildable_product_runnable) && action.buildable_product_runnable
      action.buildable_product_runnable.buildable_reference.set_reference_target(new_target, true, project)
    end
  end

  # Handle TestAction separately if needed
  if scheme.test_action
    # Update TestAction buildable references here if necessary
  end

  # Save the updated scheme
  scheme.save!
end

# Update scheme names
Dir.glob("#{schemes_path}/*.xcscheme").each do |scheme_path|
  scheme_name = File.basename(scheme_path, ".xcscheme")
  new_scheme_name = scheme_name.gsub(old_project_name, new_project_name)
  File.rename(scheme_path, "#{schemes_path}/#{new_scheme_name}.xcscheme")
end

# Update productName in PBXNativeTarget section
project.native_targets.each do |native_target|
    puts "native target --  '#{native_target}'"
  if native_target.name == new_project_name
    puts "Updating productName for target '#{new_project_name}'"
    native_target.build_configuration_list.build_configurations.each do |config|
      config.build_settings['PRODUCT_NAME'] = new_project_name
    end
  end
end

# Inspect the "new_project_name" target
target = project.targets.find { |t| t.name == new_project_name }
target.product_name = new_project_name

# Save the project before renaming the directory
project.save
puts "Project directory, scheme, and project updated."
RUBY_SCRIPT

# Remove xcodeproj, if installed
if [ "$XCODEPROJ_INSTALLED" = true ]; then
    echo "Removing xcodeproj..."
    gem uninstall xcodeproj -x

else
    echo "xcodeproj gem was already installed, not removing."
fi

 if [ -n "$newly_installed" ]; then
     echo "Uninstalling newly installed gems..."
     gem uninstall $newly_installed
     echo "Uninstallation complete."
 fi
 
 # Remove the create_swift_app.sh script
rm -f "$DESTINATION_PATH/create_swift_app.sh"

echo -e "\033[32mProject $NEW_APP_NAME created successfully. \033[0m\n"

