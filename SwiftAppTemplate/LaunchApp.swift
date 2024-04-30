//
//  LaunchApp.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI
import Firebase


@main
struct LaunchApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    init() {
        Preferences.applyAppearance(Preferences.appearanceMode)
    }

    var body: some Scene {
        WindowGroup {
            RootCoordinator()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate  {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
