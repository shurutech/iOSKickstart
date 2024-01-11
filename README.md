# iOS-App-Boilerplate

## APP ENTRY POINT:
 - SwiftAppTemplateApp.swift file: When user clicks app icon, this will be the starting code for app. It should not have any heavy components. It will navigate to first View. Here we are using RootCoordinator.
 
 **Screens Folder**
 
  RootCoordinator:
   - This is initial view which will decide the flow of screens for Splash, Authorisation(Login/Signup), TermsAndConditions, Onboarding, MainTabs Views. This uses the RootViewModel for logics. Here we can add or remove screens as per App flow.
   - RootViewModel's start method will have App start set ups and configurations.
   - This basically handles the screens which are shown once during first time walkthrough flow. In this template we are showing these screens every time, but these can be handled by having variables in UserPreferences(Local storage) 
   - When all the screens will be visited then it will be navigate to MainTabCoordinator which have Main Tab screens.
   
   MainTabCoordinator:
    - This contains all main tabs, in template we have Home, Profile and Support.
    - This uses MainTabViewModel for getting data of a particular Tab's screen.
    - Particular tab screen will have there own content.
    
**ReusableViews Folder**
  - Here we have all the sub views or components that have multiple uses in different screens for example PrimaryButtonView or some list's single item View
  
** Managers Folders **
  - Here we have Manager classes that are used to handle specific App Level functions for example we can use AuthenticationManager that manages Auth0 functionality for login/signup or logout 

## NETWORKING:

** Network Folder **
 - For rest API requests we are using Alamofire package. 
 - We have NetworkManager class which have API request method that handles success and error
 - All the API endpoints are included in APIEndpoints enum
 
** Service Folder **
  - Here we have classes related to specific service that is used to make API calls for example UserService for get/update/delete a User
  - Service class will call request method of Network class.
  - Service will be used in particular screen's ViewModel class to provide data
  
** Models Folder **
  - Here we have data structs which will be used to map the json Data used with APIs request and response.
  

## APP UTILITY:
 
 ** Utils Folder **
 - Here we have all utility classes/structs that are used at app level like Fonts/Colors/Constants etc.
 - KeyChainStorage: This is used to set/get data locally in encrypted format, uses KeychianSwift package and helpful while saving/retrieving Secure Data like AUTHORIZATION TOKEN
 - UserPreferences: This is used set/get data locally with device's User Defaults. This does not store data in encrypted format.

 ** Resources Folder **
 - All the resource files like images, fonts, strings are kept in folder.
 - Images/icons for different device resolutions, App icon, colors for different themes like Dark/Light are managed in Assets file. 
 - Localizable have static Texts used in app. This is also used to create app content in different languages.

 ** Configuration Folder **
 - Here we have app configuration files such as Debug and Release.
 - Staging or Production environment specific variables like BASE_URL, KEY/TOKEN are stored in respective config files.
 - These variables are mapped in info.plist file
 - We can change APP_NAME, APP_ICON etc for debug and release configurations
 - Reference: https://www.appcoda.com/xcconfig-guide/

   

