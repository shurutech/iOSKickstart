//
//  CustomBottomSheetView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 12/01/24.
//

import SwiftUI

struct CustomBottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    @Binding var isLoaderVisible: Bool
    let maxHeight: CGFloat
    let content: Content
    var showIndicator: Bool

    
    @GestureState private var translation: CGFloat = 0
    
    init(isOpen: Binding<Bool>, isLoaderVisible: Binding<Bool> = Binding.constant(false), maxHeight: CGFloat, showIndicator: Bool = true, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self._isLoaderVisible = isLoaderVisible
        if(maxHeight == .infinity){
            self.maxHeight = UIScreen.main.bounds.height - 50
        } else {
            self.maxHeight = maxHeight
        }
        self.content = content()
        self.showIndicator = showIndicator
    }
    
    var body: some View {
        
        ZStack{
            Color.black.opacity(isOpen ? 0.5 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.isOpen = false
                }
            
            GeometryReader { geometry in
                ZStack{
                    VStack {
                        if(self.showIndicator){
                            Image(systemName: "minus.rectangle.fill")
                                .resizable()
                                .foregroundColor(.gray.opacity(0.8))
                                .frame(width: 50, height: 10)
                                .cornerRadius(30)
                                .padding(.top, 10)
                        }
                        self.content
                    }
                    .background(Color.background)
                    .cornerRadius(20)
                    .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
                    .frame(height: geometry.size.height, alignment: .bottom)
                    .offset(y: self.isOpen ? 50 : geometry.size.height)
                    .offset(y: max(min(self.translation, self.maxHeight), 0))
                    .animation(.interactiveSpring(), value: isOpen)
                    .gesture(
                        DragGesture().updating(self.$translation) { value, state, _ in
                            state = value.translation.height
                        }.onEnded { value in
                            let snapDistance = self.maxHeight * 0.25
                            guard abs(value.translation.height) > snapDistance else {
                                return
                            }
                            self.isOpen = value.translation.height < 0
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    CustomBottomSheetView(isOpen: Binding.constant(true), maxHeight: 300, content: {})
}
