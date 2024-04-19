//
//  CustomTextField.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 09/01/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var inputText: String
    var placeholder: String
    var cornerRadius: CGFloat
    var borderColor: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            if inputText.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
            }
            
            TextField("", text: $inputText)
                .foregroundColor(.text)
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 1)
                )
        }
    }
}

#Preview {
    CustomTextField(inputText: Binding.constant(""), placeholder: "Enter Text", cornerRadius: 8, borderColor: Color.blue)
}
