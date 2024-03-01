![ic_launcher](https://github.com/shurutech/ios-swift-template/assets/127201055/bc2cacf3-92cb-41de-af15-9a5ece810618)
# iOS-Swift-Template

 - An iOS app template built with SwiftUI. This template is designed for creating new iOS apps with a basic screen flow: Splash > Authorization/Login-SignUp > Terms & Conditions > Onboarding (Carousel) > Main Tab Screens. These screens use dummy content. Adding new screens or deleting existing ones can be easily managed, and the app features an organized folder structure for different types of files.

 **Just use one command and create new iOS App**
   
```

 bash <(curl -fsSL "https://raw.githubusercontent.com/shurutech/ios-swift-template/main/create_swift_app.sh") -i
    
```

   - Copy the above command and paste into terminal.
   - This process will prompt you for input, such as the new app's name, whether a sidebar is required (y for yes or n for no), the number of tabs needed in the created app (between 2 to 5), and whether the Terms and Conditions and Onboarding screens are required.
   - New app will be created on Desktop

 ## Demo Video

https://github.com/shurutech/ios-swift-template/assets/127201055/c5344d73-d3a3-453f-bf8e-d865e36558bf


 **Requirements:**
  -  Xcode 15+
  -  MacOS
 

   
 
 **Post App Creation**
   After creating your app, follow these steps:

   - Open the newly created app in Xcode and check the Configuration Folder. Update the values of variables such as APP_NAME, APP_BUNDLE_ID, and BASE_URL in the Debug and Release configuration files as per your project. Note that different APP_BUNDLE_IDs are used for debug and release modes. To create a single app for both modes, ensure both bundle IDs are the same.
   
   - Update Launcher icon and Splash logo as per App display. Icons and images can be updated from Assets file located in Resources folder. 

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

# Next Steps/Features
- Add authentication methods and allow developers to select as there preference
- Make main tabs name as per developer choice
- Make the app template more generic based on developers feedback
  

# Contribution Guidelines

Thank you for your interest in contributing to our iOS Swift Template project! We value the contributions of each developer and encourage you to share your ideas, improvements, and fixes with us. To ensure a smooth collaboration process, please follow these guidelines.

## Getting Started

Before you begin:
- Make sure you have a GitHub account.
- Familiarize yourself with the project by reading the README, exploring the issues, and understanding the app's architecture and coding standards.

## How to Contribute

### Reporting Bugs

Before reporting a bug, please:
- Check the issue tracker to ensure the bug hasn't already been reported.
- If the issue is unreported, create a new issue, providing:
  - A clear title and description.
  - Steps to reproduce the bug.
  - Expected behavior and what actually happened.
  - Any relevant error messages or screenshots.

### Suggesting Enhancements

We love to receive suggestions for enhancements! Please:
- First, check if the enhancement has already been suggested.
- If not, open a new issue, describing the enhancement and why it would be beneficial.

### Pull Requests

Ready to contribute code? Follow these steps:
1. **Fork the repository** - Create your own fork of the project.
2. **Create a new branch** for your changes - Keep your branch focused on a single feature or bug fix.
3. **Commit your changes** - Write clear, concise commit messages that explain your changes.
4. **Follow the coding standards** - Ensure your code adheres to the coding standards used throughout the project.
5. **Write tests** - If possible, write tests to cover the new functionality or bug fix.
6. **Ensure the test suite passes** - Run the project's tests to ensure your changes don't break existing functionality.
7. **Submit a pull request** - Provide a clear description of the problem and solution. Include the relevant issue number if applicable.

## Conduct

We are committed to providing a welcoming and inspiring community for all. By participating in this project, you are expected to uphold our Code of Conduct, which promotes respect and collaboration.

## Questions?

Feel free to contact the project maintainers if you have any questions or need further guidance on contributing.

Thank you for contributing to our iOS App Template project! Your efforts help make our project better for everyone.


## Contributors

- [@vijay-shuru](https://github.com/vijay-shuru) - Vijay Goswami
- [@gunveer-shuru](https://github.com/gunveer-shuru) - Gunveer Sandhu
- [@ashok-shuru](https://github.com/ashok-shuru) - Ashok Kumar

