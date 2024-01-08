//
//  CardView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 04/01/24.
//

import SwiftUI

struct CardView: View {
    var title = "Title"
    var subTitle = "SubTitle"
    var backgroundColor = Color.white
    var cornerRadius = 10.0
    var shadowRadius = 5.0
    var borderColor = Color.gray
    var borderWidth = 1.0
    
    var body: some View {
        VStack(spacing: 20){
            Text(title)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subTitle)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .shadow(radius: shadowRadius)
        .border(borderColor, width: borderWidth)
        
    }
}

#Preview {
    CardView()
}
