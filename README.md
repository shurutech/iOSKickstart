# iOS-Swift-Template
 - An iOS app template built with SwiftUI. This template is designed for creating new iOS apps with a basic screen flow: Splash > Authorization/Login-SignUp > Terms & Conditions > Onboarding (Carousel) > Main Tab Screens. These screens use dummy content. Adding new screens or deleting existing ones can be easily managed, and the app features an organized folder structure for different types of files.  
 
 **Requirements:**
  -  Xcode 15+
  -  MacOS
 
 **Create New App**
   - You can create a new app with the following terminal command. This process will prompt you for input, such as the new app's name, whether a sidebar is required (y for yes or n for no), the number of tabs needed in the created app (between 2 to 5), and whether the Terms and Conditions and Onboarding screens are required.
   - ```bash <(curl -fsSL "https://raw.githubusercontent.com/shurutech/ios-swift-template/main/create_swift_app.sh?token=GHSAT0AAAAAACMJXZ3AN5E5I5UNEGGQWS2KZOULLUA") -i```
 
 **Post App Creation**
   After creating your app, follow these steps:

   - Open the newly created app in Xcode and check the Configuration Folder. Update the values of variables such as APP_NAME, APP_BUNDLE_ID, and BASE_URL in the Debug and Release configuration files as per your project. Note that different APP_BUNDLE_IDs are used for debug and release modes. To create a single app for both modes, ensure both bundle IDs are the same.

   - Dummy-Use&Delete Folder: This folder contains example files used in TabScreens and for API flow use cases. For networking or API use cases, the Open Weather API is utilized for fetching weather data in the app. Use these files for reference, then delete them later.
   
## App Folders & Files
   APP ENTRY POINT:
 - LaunchApp.swift: The starting point of the app when the user clicks the app icon. It navigates to the first view using RootCoordinator, without any heavy components.
 
 **Screens Folder**
 
 - RootCoordinator: Determines the flow of screens (Splash, Authorization, Terms and Conditions, Onboarding, Main Tabs). It uses RootViewModel for logic, handling the walkthrough flow once and saving state in UserPreferences (local storage).

 - MainTabCoordinator: Contains all main tabs (e.g., Tab1, Tab2...). Each tab has its own content and screens (e.g., Tab1Screen, Tab2Screen...). Includes a side menu bar accessible from the top-left menu button. https://medium.com/geekculture/side-menu-in-ios-swiftui-9fe1b69fc487
    
**ReusableViews Folder**
  - Contains all subviews or components used in multiple screens, e.g., PrimaryButtonView or a list's single item view.
  
**Managers Folder**
  - Contains Manager classes for handling specific app-level functions, e.g., AuthenticationManager for managing Auth0 functionality (login/signup/logout). 

## NETWORKING:

**Network Folder**
 - Utilizes the Alamofire package for REST API requests. The NetworkManager class handles API requests, including success and error management. All the API endpoints are included in APIEndpoints enum.
 
**Service Folder**
  - Contains classes for specific services making API calls, e.g., UserService for user-related operations. Services call the network class's request method and are used in screen ViewModel classes.
  
**Models Folder**
  - Contains data structures for mapping JSON data used with API requests and responses.
  

## APP UTILITY:
 
 **Utils Folder**
 - Contains utility classes/structs for app-level use, such as Fonts, Colors, Constants, etc. Includes KeyChainStorage for encrypted local data storage and UserPreferences for unencrypted local storage.

 **Resources Folder**
 - All the resource files like images, fonts, strings are kept in this folder.
 - Images/icons for different device resolutions, App icon, colors for different themes like Dark/Light are managed in Assets file. 
 - Localizable have static Texts used in app. Also used to create static app strings in different languages.
 

 **Configuration Folder**
 - Contains app configuration files for Debug and Release modes, including environment-specific variables. These variables are mapped in the Info.plist file, allowing changes to app name, icon, etc., for different configurations.
 - For more details on managing Xcode configurations: https://www.appcoda.com/xcconfig-guide/

