//
//  ProfileTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct ProfileScreen: View {
    @State var presentSettingsPage = false
    
    var body: some View {
        NavigationView{
            VStack{
                Image(systemName: "person.crop.rectangle.fill")
                    .resizable()
                    .frame(width: 150, height: 100)
                    .clipShape(Circle())
                UserInfoView()
                NavigationLink(destination: SettingsScreen()){
                    HStack{
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(LocalizedStringKey("Settings"))
                            .font(.notoSansRegular16)
                    }.foregroundColor(.secondaryLightBlue)
                }
                Spacer()
            }.padding(.horizontal, 25)
        }
    }
}

struct UserInfoView: View{
    @State var name = ""
    @State var email = ""
    
    var body: some View{
        VStack{
            TextKeyValueView(key: "Name:", value: name)
            TextKeyValueView(key: "Email:", value: email)
        }
        .foregroundColor(.primaryNavyBlue)
        .onAppear{
            name  = UserPreferences().userName
            email  = UserPreferences().userEmail
        }
    }
    
}

#Preview {
    ProfileScreen()
}
