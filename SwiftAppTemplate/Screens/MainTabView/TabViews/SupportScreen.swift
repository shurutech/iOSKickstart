//
//  SettingsTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct SupportScreen: View {
    @State private var isLoading = true
    @State private var showError = false
    var urlString = "https://shurutech.com/"
    
    var body: some View {
        VStack{
            WebView(urlString: urlString, isLoading: $isLoading, showError: $showError)
        }
        .loader(isLoading)
        .alert(isPresented: $showError){
            Alert(
                title: Text("Error"),
                message: Text("Cannot load the webpage. Something went wrong."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    SupportScreen()
}
