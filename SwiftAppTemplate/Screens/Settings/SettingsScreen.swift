//
//  SettingsView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 08/01/24.
//

import SwiftUI

struct SettingsScreen: View {
    // MARK: - Attributes
    
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: 30){
            CustomTextField(inputText: $userName, placeholder: "Enter Name", cornerRadius: 10, borderColor: .primary)
            
            CustomTextField(inputText: $userEmail, placeholder: "Enter Email", cornerRadius: 10, borderColor: .primary)
            
            
            TextButton(onClick: {
                onSaveClick()
            }, text: "Save")
            
            Spacer()
            
            TextButton(onClick: {}, text: "Logout", style: .outline)
        }
        .onAppear{
            setup()
        }
        .padding()
        .navigationTitle(LocalizedStringKey("Settings"))
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Functions
    
    func onSaveClick(){
        UserPreferences().userName = userName
        UserPreferences().userEmail = userEmail
        dismiss()
    }
    
    func setup(){
        userName = UserPreferences().userName
        userEmail = UserPreferences().userEmail
    }
}

#Preview {
    SettingsScreen()
}
