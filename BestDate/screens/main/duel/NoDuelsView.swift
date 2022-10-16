//
//  NoDuelsView.swift
//  BestDate
//
//  Created by Евгений on 16.10.2022.
//

import SwiftUI

struct NoDuelsView: View {
    @Binding var loading: Bool
    var clickAction: () -> Void

    var body: some View {
        ZStack {
            if loading {
                VStack {
                    ProgressView()
                        .tint(ColorList.white.color)
                        .frame(width: 80, height: 80)
                }.frame(width: UIScreen.main.bounds.width - 36, height: 100)
            } else {
                VStack {
                    Image("ic_sad_smile")

                    Text(NSLocalizedString("duels_are_over", comment: "Over"))
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 32))

                    Text(NSLocalizedString("sorry_you_voted_for_all_the_photos", comment: "All").uppercased())
                        .foregroundColor(ColorList.pink.color)
                        .font(MyFont.getFont(.NORMAL, 14))

                    ToTopListButton {
                        withAnimation {
                            clickAction()
                        }
                    }.padding(.init(top: 40, leading: 0, bottom: 10, trailing: 0))

                    Text(NSLocalizedString("you_can_go_to_the_top", comment: "Open"))
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.NORMAL, 16))
                        .multilineTextAlignment(.center)
                }.frame(width: UIScreen.main.bounds.width - 36, height: 300)
            }
        }.background(MyColor.getColor(41, 50, 54))
    }
}
