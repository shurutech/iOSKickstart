//
//  Tab1Screen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 23/01/24.
//

import SwiftUI

struct Tab1Screen: View {
    var body: some View {
        VStack {
            Text(AppStrings.Tab) + Text("1")
            WeatherScreen()  // Use and Delete Screen , This should be removed
        }
    }
}

#Preview {
    Tab1Screen()
}
