//
//  HomeTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        ScrollView{
            VStack{
                ForEach(0..<10){_ in
                    CardView().padding(5)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    HomeTabView()
}
