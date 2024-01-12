//
//  MainTabCoordinator.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct MainTabCoordinator: View {
    @StateObject var viewModel: MainTabViewModel = MainTabViewModel()
    @State var presentSideMenu: Bool = false
    var edgeTransition: AnyTransition = .move(edge: .leading)
    
    
    var body: some View {
        ZStack(alignment: .top){
            VStack{
                topSideMenu
                
                TabView(selection: $viewModel.selectedTab) {
                    ForEach(viewModel.tabs, id: \.self) { tab in
                        tab.tabItem.view
                            .tabItem {
                                Label(tab.tabItem.title, systemImage: tab.tabItem.icon)
                            }
                            .tag(tab)
                    }

                }
                .accentColor(.primaryNavyBlue)
            }
            
            if (presentSideMenu) {
                SideMenuView(selectedSideMenuTab: $viewModel.selectedTab, presentSideMenu: $presentSideMenu)
                    .transition(edgeTransition)
                    .animation(.easeInOut, value: presentSideMenu)
            }
        }
    }
    
    var topSideMenu: some View{
        HStack{
            Button{
                withAnimation{
                    presentSideMenu = true
                }
            } label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 32, height: 24)
            }
            .foregroundColor(.primaryNavyBlue)
            .padding()
            Spacer()
        }
    }
}

#Preview {
    MainTabCoordinator()
}
