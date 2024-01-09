//
//  SettingsView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 08/01/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    
    var body: some View {
        VStack(spacing: 30){
            CustomTextField(inputText: $userName, placeholder: "Enter Name", cornerRadius: 10, borderColor: .blue)
            
            CustomTextField(inputText: $userEmail, placeholder: "Enter Email", cornerRadius: 10, borderColor: .blue)
            
            
            TextButton(onClick: {}, text: "Save")
            
            Spacer()
            
            TextButton(onClick: {}, text: "Logout", style: .outline)
        }.padding()
            .navigationTitle(LocalizedStringKey("Settings"))
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SettingsView()
}
