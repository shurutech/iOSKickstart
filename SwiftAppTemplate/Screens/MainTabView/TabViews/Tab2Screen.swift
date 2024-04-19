//
//  Tab2Screen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 23/01/24.
//

import SwiftUI

struct Tab2Screen: View {
    var body: some View {
        VStack {
            Text(getLocalString("Tab")+"2")
            ProfileScreen()  // Use and Delete Screen , This should be removed
        }
    }
}

#Preview {
    Tab2Screen()
}
