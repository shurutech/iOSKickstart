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
}

enum Tab: CaseIterable{
    case home
    case profile
    case support
}

