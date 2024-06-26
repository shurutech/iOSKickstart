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
                
                tabView
            }
            
            if (presentSideMenu) {
                SideMenuView(selectedSideMenuTab: $viewModel.selectedTab, presentSideMenu: $presentSideMenu)
                    .transition(edgeTransition)
                    .animation(.easeInOut, value: presentSideMenu)
            }
        }
    }
    
    var tabView: some View{
        TabView(selection: $viewModel.selectedTab,
                content:  {
            Tab1Screen().tabItem { TabItem(title: getLocalString("Tab")+"1", icon: "1.circle.fill") }.tag(Tab.tab1)
            Tab2Screen().tabItem { TabItem(title: getLocalString("Tab")+"2", icon: "2.circle.fill") }.tag(Tab.tab2)
        })
        .accentColor(.primaryNavyBlue)
        .onAppear{
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.secondaryLightBlue)
        }
    }
    
    var topSideMenu: some View{
        HStack{
            Button{
                withAnimation{
                    AnalyticsManager.logButtonClickEvent(buttonType: .secondary, label: "Side menu")
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
