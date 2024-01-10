//
//  HomeTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var isInfoScreenPresented = false
    @State var selectedNum = 0
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(showsIndicators: false){
                    VStack(spacing: 20){
                        ForEach(0..<10){i in
                            CardView(infoAction: {
                                selectedNum = i
                                isInfoScreenPresented = true
                            }).padding(5)
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal, 20)
                NavigationLink(destination: InfoScreen(cardNum: selectedNum), isActive: $isInfoScreenPresented){}
            }
        }
    }
}

#Preview {
    HomeScreen()
}
