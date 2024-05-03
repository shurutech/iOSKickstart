//
//  SideMenuView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 12/01/24.
//

import SwiftUI

struct SideMenuView: View {
    
    @Binding var selectedSideMenuTab: Tab
    @Binding var presentSideMenu: Bool
    @State var screenWidth: CGFloat = 0
    @State private var userName: String = UserPreferences.shared.getUser()?.name ?? ""
    @State private var userEmail: String = UserPreferences.shared.getUser()?.email ?? ""
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack{
                Rectangle()
                    .fill(.gray)
                    .frame(width: screenWidth * (2/3))
                    .shadow(color: .primaryNavyBlue.opacity(0.9), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .center, spacing: 0) {
                    UserInfoView(name: $userName, email: $userEmail)
                        .padding(.top, 100)
                        .padding(.bottom, 50)
                    
                    menuItems
                    
                    Spacer()
                }
                .frame(width: screenWidth * (2/3))
                .background(
                    Color.background.opacity(0.9)
                )
            }
            Rectangle()
                .opacity(0.1)
                .onTapGesture{
                    presentSideMenu.toggle()
                }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            screenWidth = UIScreen.main.bounds.width
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
            
        }
    }
    
    var menuItems: some View{
        VStack{
            RowView(isSelected: $selectedSideMenuTab.wrappedValue == Tab.tab1, imageName: "1.circle.fill", title:getLocalString("Tab")+"1", action: {
                AnalyticsManager.logButtonClickEvent(buttonType: .text, label: "Tab1")
                selectedSideMenuTab = .tab1
                presentSideMenu.toggle()
            })
            RowView(isSelected: $selectedSideMenuTab.wrappedValue == Tab.tab2, imageName: "2.circle.fill", title: getLocalString("Tab")+"2", action: {
                AnalyticsManager.logButtonClickEvent(buttonType: .text, label: "Tab2")
                selectedSideMenuTab = .tab2
                presentSideMenu.toggle()
            })
        }
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? Color.primaryNavyBlue : .clear)
                        .frame(width: 5)
                    
                    Image(systemName: imageName)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(isSelected ? Color.primaryNavyBlue : .gray)
                        .frame(width: 26, height: 26)
                    
                    Text(title)
                        .font(.notoSansBold16)
                        .foregroundColor(isSelected ? Color.primaryNavyBlue : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .primaryNavyBlue.opacity(0.5) : .clear, .clear], startPoint: .leading, endPoint: .trailing)
        )
    }
}


#Preview {
    SideMenuView(selectedSideMenuTab: Binding.constant(Tab.tab1), presentSideMenu: Binding.constant(true))
}
