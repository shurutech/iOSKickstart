//
//  Tab5Screen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 23/01/24.
//

import SwiftUI

struct Tab5Screen: View {
    var body: some View {
        VStack {
            Text(AppStrings.Tab) + Text("5")
        }
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }
}

#Preview {
    Tab5Screen()
}
