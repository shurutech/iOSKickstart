//
//  CustomTitleTextFieldView.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 25/04/24.
//

import SwiftUI

struct CustomTitleTextFieldView: View {
    var label: LocalizedStringKey
    var placeholder: LocalizedStringKey
    @Binding var inputText: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            CustomTextField(inputText: $inputText, placeholder: placeholder, cornerRadius: 10, borderColor: .primaryNavyBlue)
        }
    }
}

#Preview {
    CustomTitleTextFieldView(label: "Title", placeholder: "Enter title", inputText: Binding.constant(""))
}
