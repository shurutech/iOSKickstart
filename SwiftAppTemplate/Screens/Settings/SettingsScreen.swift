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
    @State private var showConfirmationSheet = false
    @State private var isConfirmationGiven = false
    @State private var isLogoutClicked = false
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Views
    
    var body: some View {
        ZStack{
            VStack(spacing: 30){
                Header(text: "Settings", hasBackButton: true, onBackArrowClick: {
                    dismiss()
                })
                
                CustomTextField(inputText: $userName, placeholder: "Enter Name", cornerRadius: 10, borderColor: .primaryNavyBlue)
                
                CustomTextField(inputText: $userEmail, placeholder: "Enter Email", cornerRadius: 10, borderColor: .primaryNavyBlue)
                
                
                TextButton(onClick: {
                    showConfirmationSheet = true
                }, text: "Save")
                
                Spacer()
                
                TextButton(onClick: {
                    showConfirmationSheet = true
                    isLogoutClicked = true
                }, text: "Logout", style: .outline)
            }.padding()
            CustomBottomSheetView(isOpen: $showConfirmationSheet, maxHeight: 260, content: {
                ConfirmationSheet(isConfirmationGiven: $isConfirmationGiven, isOpen: $showConfirmationSheet)
            }).onChange(of: isConfirmationGiven, perform: { value in
                if value {
                    isLogoutClicked ? onLogoutClick() : onSaveClick()
                }
            })
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            setup()
        }
    }
    
    // MARK: - Functions

    
    private func onSaveClick(){
        if(isConfirmationGiven){
            UserPreferences().userName = userName
            UserPreferences().userEmail = userEmail
            dismiss()
        }
    }
    
    private func setup(){
        userName = UserPreferences().userName
        userEmail = UserPreferences().userEmail
    }
    
    private func onLogoutClick(){
        if(isConfirmationGiven){
            isConfirmationGiven = false
            logout()
        }
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
