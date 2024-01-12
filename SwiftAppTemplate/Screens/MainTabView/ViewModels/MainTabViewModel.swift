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

