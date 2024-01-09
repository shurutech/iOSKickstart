//
//  AuthenticationScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AuthorizationScreen: View {
    private let title: LocalizedStringKey = "Login/SignUp"
    private let buttonLabel: LocalizedStringKey = "Login"
    
    @State var name: String = ""
    @State var password: String = ""
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: title)
                nameField
                    .padding(.vertical, 20)
                passwordField
                Spacer()
                TextButton(onClick: onLoginButtonClick, text: buttonLabel, color: canLogin() ? .primary : .gray)
            }
            .padding()
        }
    }
    
    var nameField : some View {
        VStack(alignment: .leading) {
            Text("Name")
                .font(.notoSansMedium16)
                .foregroundColor(.primary)
            TextField("Your name", text: $name)
                .padding(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary,  lineWidth: 1)
                )
        }
    }
    
    var passwordField : some View {
        VStack(alignment: .leading) {
            Text("Password")
                .font(.notoSansMedium16)
                .foregroundColor(.primary)
            SecureField("Password", text: $password)
                .padding(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary,  lineWidth: 1)
                )
        }
    }
    
    //MARK: - Functions
    
    private func onLoginButtonClick() {
        if(!canLogin()){
            return
        }
        AuthenticationManager.shared.login()
    }
    
    private func canLogin() -> Bool{
        return !name.isEmpty && !password.isEmpty
    }
}

#Preview {
    AuthorizationScreen()
}

