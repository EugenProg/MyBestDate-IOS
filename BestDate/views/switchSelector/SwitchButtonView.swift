//
//  SwitchButtonView.swift
//  BestDate
//
//  Created by Евгений on 15.06.2022.
//

import SwiftUI

struct SwitchButtonView: View {
    @Binding var isActive: Bool?
    var unactiveColor: Color = ColorList.pink.color
    var activeColor: Color = ColorList.light_blue.color
    @State var buttonOffset: CGFloat = -13
    @Binding var isEnabled: Bool

    var checkAction: (Bool) -> Void

    init(isActive: Binding<Bool?> = .constant(true),
         isEnabled: Binding<Bool> = .constant(true),
         checkAction: @escaping (Bool) -> Void) {
        self._isActive = isActive
        self._isEnabled = isEnabled
        self.checkAction = checkAction
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .fill(isActive == true ? activeColor : unactiveColor)
                .frame(width: 44, height: 18, alignment: .center)
            
            Circle()
                .stroke(MyColor.getColor(231, 238, 242, 0.12), lineWidth: 14)
                .background(ColorList.main.color)
                .cornerRadius(16)
                .shadow(color: MyColor.getColor(0, 0, 0, 0.16), radius: 6, y: 3)
                .frame(width: 32, height: 32, alignment: .center)
                .offset(x: buttonOffset, y: 0)
        }
        .frame(width: 58, height: 32)
        .padding(16)
        .onTapGesture {
            if isEnabled {
                withAnimation {
                    isActive?.toggle()
                    checkAction(isActive == true)
                    buttonOffset = (isActive == true) ? 13 : -13
                }
            }
        }
        .onAppear {
            buttonOffset = (isActive == true) ? 13 : -13
        }
    }
}
