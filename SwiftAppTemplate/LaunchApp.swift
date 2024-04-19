//
//  LaunchApp.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

@main
struct LaunchApp: App {
    
    init() {
        Preferences.applyAppearance(Preferences.appearanceMode)
    }

    var body: some Scene {
        WindowGroup {
            RootCoordinator()
        }
    }
}
