//
//  AuthenticationScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AuthorizationScreen: View {
    @State var password: String = ""
    @State var email: String = ""
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: AppStrings.LoginScreenTitle)
                
                CustomTitleTextFieldView(label: AppStrings.Email, placeholder: AppStrings.EmailPlaceHolder, inputText: $email)
                    .padding(.bottom, 20)
                
                passwordField
                
                Spacer()
                TextButton(onClick: onLoginButtonClick, text: AppStrings.Login, color: canLogin() ? .primaryNavyBlue : .gray)
            }
            .padding()
        }
    }
    
    var passwordField : some View {
        VStack(alignment: .leading) {
            Text(AppStrings.Password)
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            SecureField(AppStrings.Password, text: $password)
                .padding(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primaryNavyBlue,  lineWidth: 1)
                )
        }
    }
    
    var rectangle: some View {
        return overlay (
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.primaryNavyBlue, lineWidth: 1)
        )
    }
    
    //MARK: - Functions
    
    private func login() {
        Task { @MainActor in
            do {
                try await AuthenticationManager.shared.login(user: User(email: email, password: password))
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
        return !email.isEmpty && !password.isEmpty
    }
}

#Preview {
    AuthorizationScreen()
}

