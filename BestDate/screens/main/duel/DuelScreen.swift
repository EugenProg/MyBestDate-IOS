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
    @State var showResult: Bool = false

    @State var firstProgress: Bool = false
    @State var secondProgress: Bool = false
    @State var isSelect: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            ProfileMediator.shared.setUser(user: MainMediator.shared.user)
                            store.dispatch(action: .navigate(screen: .PROFILE))
                        }
                    }) {
                        MainHeaderImage()
                    }

                    Spacer()

                    ToTopListButton {
                        withAnimation {
                            TopListMediator.shared.activePage = mediator.activeGender
                            mediator.updateTopLists()
                            store.dispatch(action: .navigate(screen: .TOP_LIST))
                        }
                    }
                }

                Title(textColor: ColorList.white.color, text: "duel", textSize: 20, paddingV: 0, paddingH: 0)
                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 40))
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 8, trailing: 18))

            HStack {
                DropDownView(style: .blue, text: $mediator.place) {

                }

                Spacer()

                TopPagerToggle(activeType: $mediator.activeGender) {
                    nextDuel()
                }

            }.padding(.init(top: 8, leading: 18, bottom: 13, trailing: 18))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        DuelCoinsView()

                        Spacer()

                        ProfileButtonView(name: "my_duels", image: "ic_my_duels", isActive: true, size: CGSize(width: 57, height: 54)) {
                            withAnimation {
                                store.dispatch(action: .navigate(screen: .MY_DUELS))
                            }
                        }
                    }.padding(.init(top: 16, leading: 18, bottom: 16, trailing: 18))

                    if mediator.hasADuelAction {
                        HStack(spacing: 3) {
                            DuelItemView(item: $mediator.firstDuelImage, showProcess: $firstProgress, isSelect: $isSelect) {
                                voteAction(winning: mediator.firstDuelImage?.id ?? 0, luser: mediator.secondDuelImage?.id ?? 0)
                            }

                            DuelItemView(item: $mediator.secondDuelImage, showProcess: $secondProgress, isSelect: $isSelect) {
                                voteAction(winning: mediator.secondDuelImage?.id ?? 0, luser: mediator.firstDuelImage?.id ?? 0)
                            }
                        }.padding(.init(top: 0, leading: 3, bottom: 16, trailing: 3))
                    } else {
                        NoDuelData()
                            .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
                    }

                    if mediator.firstUser != nil && mediator.secondUser != nil {
                        Text(NSLocalizedString("result", comment: "Result"))
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 20))
                            .padding(.init(top: 15, leading: 18, bottom: 5, trailing: 16))

                        DuelCompareItem(item: $mediator.firstUser, image: $mediator.firstUserImage)

                        DuelCompareItem(item: $mediator.secondUser, image: $mediator.secondUserImage)
                    }
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
        mediator.voteAction(winning: winning, luser: luser) {_ in 
           nextDuel()
        }
    }

    private func nextDuel() {
        mediator.getVotePhotos() { success in
            DispatchQueue.main.async {
                withAnimation {
                    firstProgress = false
                    secondProgress = false
                    isSelect = !success
                }
            }
        }
    }
}


/*
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
                     DuelItemView(item: $mediator.firstDuelImage, showProcess: $firstProgress, isSelect: $isSelect) {
                         voteAction(winning: mediator.firstDuelImage?.id ?? 0, luser: mediator.secondDuelImage?.id ?? 0)
                     }

                     DuelItemView(item: $mediator.secondDuelImage, showProcess: $secondProgress, isSelect: $isSelect) {
                         voteAction(winning: mediator.secondDuelImage?.id ?? 0, luser: mediator.firstDuelImage?.id ?? 0)
                     }
                 }.padding(.init(top: 30, leading: 3, bottom: 16, trailing: 3))

                 if mediator.firstUser != nil && mediator.secondUser != nil {
                     Text(NSLocalizedString("result", comment: "Result"))
                         .foregroundColor(ColorList.white.color)
                         .font(MyFont.getFont(.BOLD, 20))
                         .padding(.init(top: 15, leading: 18, bottom: 5, trailing: 16))

                     DuelCompareItem(item: $mediator.firstUser, image: $mediator.firstUserImage)

                     DuelCompareItem(item: $mediator.secondUser, image: $mediator.secondUserImage)
                 }
             }
         }
     }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
     .onAppear {
         store.dispatch(action:
                 .setScreenColors(status: ColorList.main.color, style: .lightContent))
     }
 }
 */
