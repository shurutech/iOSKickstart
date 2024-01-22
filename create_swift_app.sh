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

# Argument: New App Name
NEW_APP_NAME=$1
OLD_APP_NAME="SwiftAppTemplate"
DESTINATION_PATH="$HOME/Desktop/$NEW_APP_NAME"

# Create the destination directory if it doesn't exist
mkdir -p "$DESTINATION_PATH"

# Clone the template project into the destination directory
git clone https://github.com/shurutech/ios-swift-template.git "$DESTINATION_PATH"

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

# Execute Ruby script
ruby << RUBY_SCRIPT
require 'xcodeproj'

old_project_name = "$OLD_APP_NAME"
new_project_name = "$NEW_APP_NAME"
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

# Assuming you want to inspect the "new_project_name" target
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

echo "Project $NEW_APP_NAME created successfully."

# Remove the create_swift_app.sh script
rm -f "$DESTINATION_PATH/create_swift_app.sh"
echo "Removed create_swift_app.sh script from $NEW_APP_NAME."
