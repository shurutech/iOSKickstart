//
//  HomeViewModel.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab = .home

    var tabs: [Tab] = [.home, .profile, .messages]
}

enum Tab {
    case home
    case profile
    case messages

    var tabItem: TabItem {
        switch self {
        case .home:
            return TabItem(title: "Home", icon: "house.circle.fill", view: AnyView(HomeTabView()))
        case .profile:
            return TabItem(title: "Profile", icon: "person.crop.circle.fill", view: AnyView(ProfileTabView()))
        case .messages:
            return TabItem(title: "Messages", icon: "message.circle.fill", view: AnyView(MessageTabView()))
        }
    }
}

