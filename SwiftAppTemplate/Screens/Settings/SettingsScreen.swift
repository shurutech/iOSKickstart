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
            
            TextButton(onClick: onLogoutClick, text: "Logout", style: .outline)
        }
        .onAppear{
            setup()
        }
        .padding()
        .navigationTitle(LocalizedStringKey("Settings"))
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Functions
    
    private func onSaveClick(){
        UserPreferences().userName = userName
        UserPreferences().userEmail = userEmail
        dismiss()
    }
    
    private func setup(){
        userName = UserPreferences().userName
        userEmail = UserPreferences().userEmail
    }
    
    private func onLogoutClick(){
        logout()
    }
    
    private func logout() {
        Task { @MainActor in
            do {
                try await AuthenticationManager.shared.logout()
            }
            catch {
                ErrorHandler.recordError(withCustomMessage: "Error logging out.", error)
            }
        }
    }
}

#Preview {
    SettingsScreen()
}
