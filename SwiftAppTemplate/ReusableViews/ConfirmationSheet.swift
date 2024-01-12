//
//  ConfirmationSheet.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 12/01/24.
//

import SwiftUI

struct ConfirmationSheet: View {
    @Binding var isConfirmationGiven: Bool
    @Binding var isOpen: Bool
    var title = "Are you sure?"
    var subTitle = "Are you really really sure that you want to go ahead with this action. It can have permanent consequences?"

    
    var body: some View {
        VStack{
            Text(title)
                .font(.notoSansBold24)
            Text(subTitle)
                .font(.notoSansMedium12)
                .padding()
            HStack{
                TextButton(onClick: {
                    isOpen.toggle()
                }, text: "Cancel", style: .outline, color: .primaryNavyBlue)
                TextButton(onClick: {
                    isConfirmationGiven.toggle()
                    isOpen.toggle()
                }, text: "Yes, sure.", style: .filled, color: .primaryNavyBlue)
            }.padding(.bottom, 20)
        }.padding()
    }
}

#Preview {
    ConfirmationSheet(isConfirmationGiven: Binding.constant(false), isOpen: Binding.constant(true))
}
