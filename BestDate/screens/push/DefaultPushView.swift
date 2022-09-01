//
//  DefaultPushView.swift
//  BestDate
//
//  Created by Евгений on 01.09.2022.
//

import SwiftUI

struct DefaultPushView: View {
    @ObservedObject var mediator = PushMediator.shared

    var closeAction: () -> Void

    var body: some View {
        ZStack {
            HStack(spacing: 16) {
                Image("ic_app_icon")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 6) {
                    Text(mediator.title ?? "")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))

                    Text(mediator.body ?? "")
                        .foregroundColor(ColorList.white_70.color)
                        .font(MyFont.getFont(.BOLD, 16))
                }
                Spacer()
            }.padding(21)
                .frame(width: UIScreen.main.bounds.width - 36)
        }.background(
            RoundedRectangle(cornerRadius: 32)
                .stroke(MyColor.getColor(255, 255, 255, 0.16), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(32)
                .shadow(color: MyColor.getColor(17, 24, 28, 0.17), radius: 46, y: 14)
        )
        .onTapGesture {
            closeAction()
        }
    }
}

