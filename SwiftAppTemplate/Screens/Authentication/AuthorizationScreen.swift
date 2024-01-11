//
//  AuthenticationScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AuthorizationScreen: View {
    private let title: String = "Login/SignUp"
    private let buttonText: String = "Login"
    private let nameTitle: String = "Name"
    private let namePlaceHolder: String = "Your name"
    private let passwordTitle: String = "Password"
    
    @State var name: String = ""
    @State var password: String = ""
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: getLocalString(title))
                nameField
                    .padding(.vertical, 20)
                passwordField
                Spacer()
                TextButton(onClick: onLoginButtonClick, text: getLocalString(buttonText), color: canLogin() ? .primary : .gray)
            }
            .padding()
        }
    }
    
    var nameField : some View {
        VStack(alignment: .leading) {
            Text(getLocalString(nameTitle))
                .font(.notoSansMedium16)
                .foregroundColor(.primary)
            TextField(getLocalString(namePlaceHolder), text: $name)
                .padding(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary,  lineWidth: 1)
                )
        }
    }
    
    var passwordField : some View {
        VStack(alignment: .leading) {
            Text(getLocalString(passwordTitle))
                .font(.notoSansMedium16)
                .foregroundColor(.primary)
            SecureField(getLocalString(passwordTitle), text: $password)
                .padding(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary,  lineWidth: 1)
                )
        }
    }
    
    //MARK: - Functions
    
    private func login() {
        Task { @MainActor in
            do {
                try await AuthenticationManager.shared.login()
            }
            catch {
                ErrorHandler.recordError(withCustomMessage: "Error logging in.", error)
            }
        }
    }
    
    private func onLoginButtonClick() {
        if(!canLogin()){
            return
        }
        
        login()
    }
    
    private func canLogin() -> Bool{
        return !name.isEmpty && !password.isEmpty
    }
}

#Preview {
    AuthorizationScreen()
}

