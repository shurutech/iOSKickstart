//
//  Header.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 04/01/24.
//

import SwiftUI

struct Header : View {
    var text: String
    var hasBackButton: Bool = false
    var onBackArrowClick: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                if(hasBackButton) {
                    Button(action: onBackArrowClick) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.primaryNavyBlue)
                    }
                }
                Spacer()
                Text(text)
                    .font(.notoSansBold24)
                    .foregroundColor(.primaryNavyBlue)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    Header(text: "Heading")
}
