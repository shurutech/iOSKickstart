//
//  Tab4Screen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 23/01/24.
//

import SwiftUI

struct Tab4Screen: View {
    var body: some View {
        VStack {
            Text(AppStrings.Tab) + Text("4")
        }
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self), screenClass: String(describing: Self.self))
        }
    }
}

#Preview {
    Tab4Screen()
}
