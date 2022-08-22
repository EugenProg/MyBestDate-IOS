//
//  InvitationsPagerToggleView.swift
//  BestDate
//
//  Created by Евгений on 21.08.2022.
//

import SwiftUI

struct InvitationsPagerToggleView: View {
    @Binding var activePage: InvitationType

    fileprivate func pageButton(type: InvitationType) -> some View {
        Button(action: {
            withAnimation {
                if activePage != type {
                    activePage = type
                }
            }
        }) {
            Text(type.title)
                .foregroundColor(activePage == type ? ColorList.white.color : ColorList.white_50.color)
                .font(MyFont.getFont(.BOLD, 14))
                .padding(.init(top: 8, leading: 20, bottom: 8, trailing: 20))
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .fill(LinearGradient(gradient: Gradient(colors: [
                            MyColor.getColor(48, 58, 62),
                            MyColor.getColor(43, 52, 56)
                        ]), startPoint: .topLeading, endPoint: .bottomTrailing))
                )

        }
    }

    var body: some View {
        HStack(spacing: 5) {
            pageButton(type: .new)

            pageButton(type: .answered)

            Spacer()

            pageButton(type: .sended)
        }.padding(.init(top: 0, leading: 18, bottom: 13, trailing: 18))
    }
}
