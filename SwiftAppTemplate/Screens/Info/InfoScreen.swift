//
//  InfoScreen.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 10/01/24.
//

import SwiftUI

struct InfoScreen: View {
    var cardNum: Int
    
    var body: some View {
        VStack{
            Text("This is card number \(cardNum)")
                .font(.notoSansBold16)
        }
        .navigationTitle(LocalizedStringKey("Details"))
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    InfoScreen(cardNum: 23)
}
