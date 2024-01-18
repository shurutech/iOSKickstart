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
    private let emailPlaceHolder: String = "Your email"
    private let passwordTitle: String = "Password"
    private let emailTitle: String = "Email"
    
    @State var name: String = ""
    @State var password: String = ""
    @State var email: String = ""
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: getLocalString(title))
                nameField
                    .padding(.vertical, 20)
                emailField
                    .padding(.bottom, 20)
                passwordField
                Spacer()
                TextButton(onClick: onLoginButtonClick, text: getLocalString(buttonText), color: canLogin() ? .primaryNavyBlue : .gray)
            }
            .padding()
        }
    }
    
    var nameField : some View {
        VStack(alignment: .leading) {
            Text(getLocalString(nameTitle))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            TextField(getLocalString(namePlaceHolder), text: $name)
                .padding(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primaryNavyBlue,  lineWidth: 1)
                )
        }
    }
    
    var passwordField : some View {
        VStack(alignment: .leading) {
            Text(getLocalString(passwordTitle))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            SecureField(getLocalString(passwordTitle), text: $password)
                .padding(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primaryNavyBlue,  lineWidth: 1)
                )
        }
    }
    
    var emailField : some View {
        VStack(alignment: .leading) {
            Text(getLocalString(emailTitle))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            TextField(getLocalString(emailPlaceHolder), text: $email)
                .padding(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primaryNavyBlue,  lineWidth: 1)
                )
        }
    }
    
    //MARK: - Functions
    
    private func login() {
        Task { @MainActor in
            do {
                try await AuthenticationManager.shared.login(user: User(name: name, password: password, email: email))
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

