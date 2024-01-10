//
//  SettingsTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct SupportScreen: View {
    var body: some View {
        WebView(urlString: "https://shurutech.com/")
            .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    SupportScreen()
}
