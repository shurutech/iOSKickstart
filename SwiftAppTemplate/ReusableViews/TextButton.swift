//  TextButton.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 05/01/24.
//

import SwiftUI

struct TextButton : View {
    enum Style {
        case filled, outline, textOnly
    }
    
    // MARK: - Attributes
    var onClick: () -> Void
    var text: String
    var style: Style = .filled
    var color: Color = .primary
    
    // MARK: - Views
    var body: some View {
        Button(action: onClick){
            Text(text)
                .font(.notoSansMedium12)
                .frame(maxWidth: .infinity)
                .padding(14)
                .foregroundColor(style == .filled ? .white : color)
                .background(style == .filled ? color : .clear)
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .inset(by: 0.75)
                        .stroke(style == .outline ? color : .clear, lineWidth: 1.5)
                )
                .contentShape(Rectangle())
            
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack{
        TextButton(onClick: {}, text: "Click Me", style: .filled, color: .primary)
        TextButton(onClick: {}, text: "Click Me", style: .outline, color: .primary)
        TextButton(onClick: {}, text: "Click Me", style: .textOnly, color: .primary)
        HStack{
            TextButton(onClick: {}, text: "Click Me", style: .outline, color: .primary)
            TextButton(onClick: {}, text: "Click Me", style: .filled, color: .primary)
        }
    }
    .padding()
}
