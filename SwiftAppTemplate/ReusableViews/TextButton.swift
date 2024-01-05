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
    var color: Color = .blue
    
    // MARK: - Views
    var body: some View {
        Button(action: onClick){
            Text(text)
                .font(.subheadline)
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
        TextButton(onClick: {}, text: "Click Me", style: .filled, color: .blue)
        TextButton(onClick: {}, text: "Click Me", style: .outline, color: .blue)
        TextButton(onClick: {}, text: "Click Me", style: .textOnly, color: .blue)
        HStack{
            TextButton(onClick: {}, text: "Click Me", style: .outline, color: .blue)
            TextButton(onClick: {}, text: "Click Me", style: .filled, color: .blue)
        }
    }
    .padding()
}
