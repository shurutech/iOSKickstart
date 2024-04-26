//
//  Tab3Screen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 23/01/24.
//

import SwiftUI

struct Tab3Screen: View {
    var body: some View {
        VStack {
            Text(AppStrings.Tab) + Text("3")
            WebScreen() // Use and Delete Screen , This should be removed
        }
    }
}

#Preview {
    Tab3Screen()
}
