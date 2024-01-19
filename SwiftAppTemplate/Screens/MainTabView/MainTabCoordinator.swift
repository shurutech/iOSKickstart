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
            HomeScreen().tabItem { TabItem(title: "Home", icon: "house.circle.fill") }.tag(Tab.home)
            ProfileScreen().tabItem { TabItem(title: "Profile", icon: "person.crop.circle.fill") }.tag(Tab.profile)
            SupportScreen().tabItem { TabItem(title: "Support", icon: "message.circle.fill") }.tag(Tab.support)
        })
        .accentColor(.secondaryLightBlue)
        .onAppear{
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.primaryNavyBlue)
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
