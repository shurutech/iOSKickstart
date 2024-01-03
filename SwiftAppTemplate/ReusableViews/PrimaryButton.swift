//
//  PrimaryButton.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct PrimaryButton: View {
    var label: String
    var onClick: () -> Void
    var isEnable: Bool
    
    // MARK: - Views
    var body: some View {
        Button(action: { onClick() }, label: {
            Text(label)
                .foregroundColor(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(isEnable ? Color.green : Color.gray)
                .cornerRadius(10)
        })
        .padding(.horizontal, 20)
    }
}

#Preview {
    PrimaryButton(label: "Button", onClick: {}, isEnable: true)
}
