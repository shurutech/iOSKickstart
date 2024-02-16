# iOS-App-Boilerplate
 - This is an iOS app template, built with SwiftUI. This template can be used for creating new iOS app that has basic screens flow like Splash > Authorisation/Login-SignUp > Terms & Conditions > Onboarding(Carousel) > Main Tab Screens. These screens use basic dummy content. Addition of any new screen or deletion of existing screen can be managed easily. App has organised folder structure for different kind of files.   
 
 **Requirements:
  -  Xcode 15+
 
 **Create New App
   - New app can be created with below terminal command. This command execution will require input like New App Name, Sidebar is required(y) or not(n) (Yes or No), Number of Tabs required in created App (Between 2 to 5), Terms and Condition screen is required or not, Onboarding screen is required or not. 
   bash <(curl -fsSL "https://raw.githubusercontent.com/shurutech/ios-swift-template/main/create_swift_app.sh?token=GHSAT0AAAAAACMJYMQ6YPVQ2DA5ZHJK2CUSZNSNOPQ") -i
 
 **Post App Creation
   - Configuration Folder: Update values of variables like APP_NAME, APP_BUNDLE_ID, BASE_URL in Debug and Release configuration files as per project.
   NOTE: Different bundle IDs are used for debug and release mode. So two different app will be created. If we want to keep same app, both bundle IDs should be same.     
   - Dummy-Use&Delete Folder: This folder has files for example purpose. Files of this folder are used in TabsScreens and for API flow use case. For Networking or API use case, Open Weather API is used for fetching weather data in app. Just use files of this folder for references and delete it later.
   
## Folder Structure
   APP ENTRY POINT:
 - LaunchApp.swift file: When user clicks app icon, this will be the starting code for app. It should not have any heavy components. It will navigate to first View. Here we are using RootCoordinator.
 
 **Screens Folder**
 
  RootCoordinator:
   - This is initial view which will decide the flow of screens for Splash, Authorisation(Login/Signup), TermsAndConditions, Onboarding, MainTabs Views. This uses the RootViewModel for logics. Here we can add or remove screens as per App flow.
   - RootViewModel's start method will have App start set ups and configurations.
   - This basically handles the screens which are shown once during first time walkthrough flow. In this template we are showing these screens every time, but these can be handled by having variables in UserPreferences(Local storage) 
   - When all the screens will be visited then it will be navigate to MainTabCoordinator which have Main Tab screens.
   
   MainTabCoordinator:
    - This contains all main tabs, in template we have Tab1, Tab2, Tab3, Tab4, Tab5.
    - Particular tab will have there own content with screens like Tab1Screen, Tab2Screen....
    - There is a SideMenubar that appears from top left menu button - https://medium.com/geekculture/side-menu-in-ios-swiftui-9fe1b69fc487
    
**ReusableViews Folder**
  - Here we have all the sub views or components that have multiple uses in different screens for example PrimaryButtonView or some list's single item View
  
**Managers Folders**
  - Here we have Manager classes that are used to handle specific App Level functions for example we can use AuthenticationManager that manages Auth0 functionality for login/signup or logout 

## NETWORKING:

**Network Folder**
 - For rest API requests we are using Alamofire package. 
 - We have NetworkManager class which have API request method that handles success and error
 - All the API endpoints are included in APIEndpoints enum
 
**Service Folder**
  - Here we have classes related to specific service that is used to make API calls for example UserService for get/update/delete a User
  - Service class will call request method of Network class.
  - Service will be used in particular screen's ViewModel class to provide data
  
**Models Folder**
  - Here we have data structs which will be used to map the json Data used with APIs request and response.
  

## APP UTILITY:
 
 **Utils Folder**
 - Here we have all utility classes/structs that are used at app level like Fonts/Colors/Constants etc.
 - KeyChainStorage: This is used to set/get data locally in encrypted format, uses KeychianSwift package and helpful while saving/retrieving Secure Data like AUTHORIZATION TOKEN
 - UserPreferences: This is used set/get data locally with device's User Defaults. This does not store data in encrypted format.

 **Resources Folder**
 - All the resource files like images, fonts, strings are kept in folder.
 - Images/icons for different device resolutions, App icon, colors for different themes like Dark/Light are managed in Assets file. 
 - Localizable have static Texts used in app. This is also used to create app content in different languages.

 **Configuration Folder**
 - Here we have app configuration files such as Debug and Release.
 - Staging or Production environment specific variables like BASE_URL, KEY/TOKEN are stored in respective config files.
 - These variables are mapped in info.plist file
 - We can change APP_NAME, APP_ICON etc for debug and release configurations
 - Reference: https://www.appcoda.com/xcconfig-guide/

   

