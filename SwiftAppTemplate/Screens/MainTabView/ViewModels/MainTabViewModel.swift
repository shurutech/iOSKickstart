//
//  MainTabViewModel.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import Foundation
import SwiftUI

class MainTabViewModel: ObservableObject {
    @Published var selectedTab: Tab = .home

    var tabs: [Tab] = [.home, .profile, .support]
}

enum Tab {
    case home
    case profile
    case support

    var tabItem: TabItem {
        switch self {
        case .home:
            return TabItem(title: LocalizedStringKey("Home"), icon: "house.circle.fill", view: AnyView(HomeScreen()))
        case .profile:
            return TabItem(title: LocalizedStringKey("Profile"), icon: "person.crop.circle.fill", view: AnyView(ProfileScreen()))
        case .support:
            return TabItem(title: LocalizedStringKey("Support"), icon: "message.circle.fill", view: AnyView(SupportScreen()))
        }
    }
}

