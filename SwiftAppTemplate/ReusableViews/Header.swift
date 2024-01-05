//
//  Header.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 04/01/24.
//

import SwiftUI

struct Header : View {
    var text: LocalizedStringKey
    var hasBackButton: Bool = false
    var onBackArrowClick: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                if(hasBackButton) {
                    Button(action: onBackArrowClick) {
                        Image(systemName: "arrow.backward")
                    }
                }
                Spacer()
                Text(text)
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    Header(text: "Heading")
}