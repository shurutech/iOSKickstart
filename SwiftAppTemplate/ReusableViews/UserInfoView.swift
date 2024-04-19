//
//  UserInfoView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 12/01/24.
//

import SwiftUI

struct UserInfoView: View{
    @Binding var name: String
    @Binding var email: String
    
    var body: some View{
        VStack{
            Image(systemName: "person.crop.rectangle.fill")
                .resizable()
                .frame(width: 150, height: 100)
                .clipShape(Circle())
            TextKeyValueView(key: getLocalString("Name") + ":" , value: name)
            TextKeyValueView(key: getLocalString("Email") + ":", value: email)
        }
        .foregroundColor(.primaryNavyBlue)
    }
}

#Preview {
    UserInfoView(name: Binding.constant("name"), email: Binding.constant("email"))
}
