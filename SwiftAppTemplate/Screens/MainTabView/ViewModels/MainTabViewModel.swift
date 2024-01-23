//
//  MainTabViewModel.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import Foundation
import SwiftUI

class MainTabViewModel: ObservableObject {
    @Published var selectedTab: Tab = .tab1
}

enum Tab: CaseIterable{
    case tab1
    case tab2
    case tab3
    case tab4
    case tab5
}

