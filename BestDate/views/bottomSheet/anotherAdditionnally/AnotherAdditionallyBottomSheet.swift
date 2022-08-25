//
//  AnotherAdditionallyBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 24.08.2022.
//

import SwiftUI

struct AnotherAdditionallyBottomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = AdditionallyMediator.shared

    var clickAction: () -> Void
    var padding: CGFloat = (UIScreen.main.bounds.width - 150) / 2

    fileprivate func button(title: String, textColor: Color, click: @escaping () -> Void) -> some View {
        VStack(spacing: 8) {
            Text(NSLocalizedString(title, comment: "text"))
                .foregroundColor(textColor)
                .font(MyFont.getFont(.BOLD, 20))
                .padding(.init(top: 20, leading: padding, bottom: 0, trailing: padding))

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(height: 1)

        }.frame(width: UIScreen.main.bounds.width - 36, height: 61)
            .padding(.init(top: 10, leading: 18, bottom: 0, trailing: 18))
            .onTapGesture {
                withAnimation { click() }
            }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "additionally", textSize: 32, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 13, trailing: 0))

            button(title: "share", textColor: ColorList.white.color) {
                clickAction()
                store.dispatch(action: .openLink(link: "https://dev-api.bestdate.info/api/documentation"))
            }

            button(title: mediator.isBlocked ? "unlock_profile" : "block_profile", textColor: MyColor.getColor(242, 138, 182)) {
                mediator.blockAction()
                clickAction()
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }
}

