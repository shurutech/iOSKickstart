//
//  TextKeyValueView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 09/01/24.
//

import SwiftUI

struct TextKeyValueView: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack{
            Text(key)
            Text(value)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TextKeyValueView(key:"Name", value: "User Name")
}
