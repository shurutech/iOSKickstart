//
//  ProfileTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct ProfileScreen: View {
    @State var presentSettingsPage = false
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                UserInfoView(name: $userName, email: $userEmail)
                HStack{
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(LocalizedStringKey("Settings"))
                        .font(.notoSansRegular16)
                }
                .onTapGesture {
                    presentSettingsPage = true
                }
                .fullScreenCover(isPresented: $presentSettingsPage, onDismiss: {
                    updateUserInfo()
                }, content: {
                    SettingsScreen()
                })
                .foregroundColor(.secondaryLightBlue)
                Spacer()
            }.padding(.horizontal, 25)
        }.onAppear{
            updateUserInfo()
        }
    }
    
    func updateUserInfo(){
        userName = UserPreferences.shared.userName
        userEmail = UserPreferences.shared.userEmail
    }
}

#Preview {
    ProfileScreen()
}
