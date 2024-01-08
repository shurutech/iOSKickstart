//
//  ProfileTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct ProfileTabView: View {
    var body: some View {
        UserInfo()
        Spacer()
        ScrollView{
            VStack{
                ForEach(0..<5){_ in
                    CardView().padding(5)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct UserInfo: View{
    var name = "User Name"
    var email = "useremail@shurutech.com"
    
    var body: some View{
        VStack{
            TextKeyValue(key: "Name:", value: name)
            TextKeyValue(key: "Email:", value: email)
        }.padding(20)
    }
    
}

struct TextKeyValue: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack{
            Text(key)
            Text(value)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ProfileTabView()
}
