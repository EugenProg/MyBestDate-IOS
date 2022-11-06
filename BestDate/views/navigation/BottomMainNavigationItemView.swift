//
//  BottomMainNavigationItemView.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct BottomMainNavigationItemView: View {

    var text: String
    var activeIcon: String
    var unActiveIcon: String
    var type: MainScreensType

    @Binding var currentScreen: MainScreensType
    @Binding var hasNewActions: Bool

    var clickAction: (MainScreensType) -> Void
    
    var body: some View {
        Button(action: {
            withAnimation { clickAction(type) }
        }) {
            ZStack {
                VStack(spacing: 8) {
                    Image(currentScreen == type ? activeIcon : unActiveIcon)
                        .padding(.init(top: 2, leading: 0, bottom: 0, trailing: 0))

                    if currentScreen == type {
                        Image("ic_active_pink")
                            .padding(.init(top: 5, leading: 0, bottom: 4, trailing: 0))
                    } else {
                        Text(text.localized())
                            .foregroundColor(ColorList.white_50.color)
                            .font(MyFont.getFont(.NORMAL, 12))
                    }
                }

                if hasNewActions {
                    ZStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(ColorList.main.color)
                                .frame(width: 12, height: 12)

                            RoundedRectangle(cornerRadius: 4)
                                .fill(ColorList.pink.color)
                                .frame(width: 8, height: 8)
                        }
                    }.frame(width: 32, height: 45, alignment: .topTrailing)
                }
            }.frame(width: 60, height: 45)
        }
    }
}
