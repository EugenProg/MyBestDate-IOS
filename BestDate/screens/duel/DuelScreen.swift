//
//  DuelScreen.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct DuelScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = DuelMediator.shared
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: "duel", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 0, trailing: 18))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        DuelCoinsView()

                        Spacer()

                        ProfileButtonView(name: "my_duels", image: "ic_my_duels", isActive: true, size: CGSize(width: 57, height: 54)) {
                            store.dispatch(action: .navigate(screen: .MY_DUELS))
                        }
                    }.padding(.init(top: 16, leading: 18, bottom: 16, trailing: 18))

                    HStack(spacing: 3) {
                        DuelItemView(item: mediator.firstUser) {
                            voteAction(winning: mediator.firstUser.id ?? 0, luser: mediator.secondUser.id ?? 0)
                        }

                        DuelItemView(item: mediator.secondUser) {
                            voteAction(winning: mediator.secondUser.id ?? 0, luser: mediator.firstUser.id ?? 0)
                        }
                    }.padding(.init(top: 30, leading: 3, bottom: 16, trailing: 3))

                    Text(NSLocalizedString("result", comment: "Result"))
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .padding(.init(top: 15, leading: 18, bottom: 5, trailing: 16))

                    DuelCompareItem(item: mediator.firstUser)

                    DuelCompareItem(item: mediator.secondUser)
                }
            }
        }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }

    private func voteAction(winning: Int, luser: Int) {
        if winning == luser { return }
        mediator.voteAction(winning: winning, luser: luser) {
            DispatchQueue.main.async {
                store.dispatch(action: .navigationBack)
            }
        }
    }
}
