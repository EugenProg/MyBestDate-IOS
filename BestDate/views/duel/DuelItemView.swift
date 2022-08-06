//
//  DuelItemView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct DuelItemView: View {
    @Binding var item: ProfileImage?
    @Binding var showProcess: Bool
    @Binding var isSelect: Bool
    var size = (UIScreen.main.bounds.width - 9) / 2
    var clickAction: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(MyColor.getColor(255, 255, 255, 0.04), lineWidth: 1)
                .background(MyColor.getColor(34, 45, 51))
                .cornerRadius(16)
                .shadow(color: MyColor.getColor(12, 28, 33, 0.24), radius: 2, y: 3)
                .frame(width: size - 8, height: size)
                .padding(.init(top: 65, leading: 4, bottom: 0, trailing: 4))

            UpdateImageView(image: $item)
                .frame(width: size, height: size)
                .padding(.init(top: 0, leading: 0, bottom: 65, trailing: 0))
                .scaleEffect(isSelect ? 0.99 : 1)
                .opacity(isSelect ? 0.99 : 1)

            Button(action: {
                if !showProcess && !isSelect {
                    withAnimation {
                        showProcess.toggle()
                        isSelect.toggle()
                        clickAction()
                    }
                }
            }) {
                ZStack {
                    Image("ic_duel_heart_decor")

                    Image("ic_duel_heart_like")
                        .padding(.init(top: 7, leading: 0, bottom: 0, trailing: 0))
                }.padding(.init(top: 6, leading: 10, bottom: 8, trailing: 10))
            }.padding(.init(top: size, leading: 0, bottom: 0, trailing: 0))

            if showProcess {
                LottieView(name: "love_burst_red", loopMode: .playOnce)
                    .frame(width: 165, height: 165)
                    .padding(.init(top: size, leading: 0, bottom: 0, trailing: 0))
            }
        }.frame(width: size, height: size + 65)
    }
}

