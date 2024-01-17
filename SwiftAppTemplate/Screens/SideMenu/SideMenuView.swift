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
    @State private var userName: String = UserPreferences().userName
    @State private var userEmail: String = UserPreferences().userEmail
    
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
                    Color.white.opacity(0.9)
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
        }
    }
    
    var menuItems: some View{
        VStack{
            RowView(isSelected: $selectedSideMenuTab.wrappedValue == Tab.home, imageName: "house.circle.fill", title: "Home", action: {
                selectedSideMenuTab = .home
                presentSideMenu.toggle()
            })
            RowView(isSelected: $selectedSideMenuTab.wrappedValue == Tab.profile, imageName: "person.crop.circle.fill", title: "Profile", action: {
                selectedSideMenuTab = .profile
                presentSideMenu.toggle()
            })
            RowView(isSelected: $selectedSideMenuTab.wrappedValue == Tab.support, imageName: "message.circle.fill", title: "Support", action: {
                selectedSideMenuTab = .support
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
    SideMenuView(selectedSideMenuTab: Binding.constant(Tab.home), presentSideMenu: Binding.constant(true))
}
