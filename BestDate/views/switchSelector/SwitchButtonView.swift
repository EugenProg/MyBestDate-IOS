//
//  SwitchButtonView.swift
//  BestDate
//
//  Created by Евгений on 15.06.2022.
//

import SwiftUI

struct SwitchButtonView: View {
    @State var isActive: Bool = false
    var unactiveColor: Color = ColorList.pink.color
    var activeColor: Color = ColorList.light_blue.color
    @State var buttonOffset: CGFloat = -13

    var checkAction: (Bool) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .fill(isActive ? activeColor : unactiveColor)
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
            withAnimation {
                isActive.toggle()
                checkAction(isActive)
                buttonOffset = isActive ? 13 : -13
            }
        }
    }
}

struct SwitchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchButtonView() { _ in }
    }
}
