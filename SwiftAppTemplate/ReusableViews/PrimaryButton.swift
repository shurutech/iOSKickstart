//
//  PrimaryButton.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct PrimaryButton: View {
    let label: String
    let onClick: () -> Void
    let isEnable: Bool
    
    // MARK: - Views
    var body: some View {
        button
        .padding(.horizontal, 20)
    }
    
    var button : some View {
        Button(action: { onClick() }, label: {
            Text(label)
                .applyButtonModifier(isEnabled: isEnable)
        })
    }
}

extension View {
    func applyButtonModifier(isEnabled: Bool) -> some View {
        modifier(ButtonModifier(isEnabled: isEnabled))
    }
}

struct ButtonModifier : ViewModifier {
    var isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(isEnabled ? Color.blue : Color.gray)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

#Preview {
    PrimaryButton(label: "Button", onClick: {}, isEnable: true)
}
