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
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
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
                ErrorHandler.logError(message: "Error while logging in.", error: error)
            }
        }
    }
    
    private func onLoginButtonClick() {
        if(!canLogin()){
            return
        }
        AnalyticsManager.logButtonClickEvent(buttonType: ButtonType.primary, label: "Login")
        login()
    }
    
    private func canLogin() -> Bool{
        return !email.isEmpty && !password.isEmpty
    }
}

#Preview {
    AuthorizationScreen()
}

