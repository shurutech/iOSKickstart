//
//  ProfileTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct ProfileTabView: View {
    @State var presentSettingsPage = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    UserInfoView()
                    NavigationLink(destination: SettingsView()){
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                Spacer()
                ScrollView{
                    VStack{
                        ForEach(0..<5){_ in
                            CardView().padding(5)
                        }
                    }
                }
            }.padding(.horizontal, 25)

        }
    }
}

struct UserInfoView: View{
    var name = "User Name"
    var email = "useremail@shurutech.com"
    
    var body: some View{
        VStack{
            TextKeyValueView(key: "Name:", value: name)
            TextKeyValueView(key: "Email:", value: email)
        }
    }
    
}

#Preview {
    ProfileTabView()
}
