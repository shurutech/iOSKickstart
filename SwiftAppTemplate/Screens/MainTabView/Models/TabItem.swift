//
//  TabItem.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import Foundation
import SwiftUI

struct TabItem {
    var title: String
    var icon: String
    var view: AnyView
}

enum Tab: CaseIterable{
    case home
    case profile
    case support

    var tabItem: TabItem {
        TabItem(title: title, icon: iconName, view: view)
    }
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        case .support:
            return "Support"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house.circle.fill"
        case .profile:
            return "person.crop.circle.fill"
        case .support:
            return "message.circle.fill"
        }
    }
    
    var view: AnyView {
        switch self {
        case .home:
            AnyView(HomeScreen())
        case .profile:
            AnyView(ProfileScreen())
        case .support:
            AnyView(SupportScreen())
        }
    }
}
