//
//  MyDuelsScreen.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import SwiftUI

struct MyDuelsScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = MyDuelsMediator.shared
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: "my_duels", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 18))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            RefreshScrollView(onRefresh: { done in
                mediator.getMyDuels(withClear: true, page: 0) { done() }
            }) {
                VStack(spacing: 0) {
                    Text("who_voted_for_me".localized())
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .padding(.init(top: 22, leading: 18, bottom: 23, trailing: 3))
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)

                    MyDuelsListView(list: mediator.duelList, meta: $mediator.meta, loadingMode: $mediator.loadingMode) { user in
                        AnotherProfileMediator.shared.setUser(user: user)
                        store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                    } loadNextPage: {
                        mediator.getNextPage()
                    }

                }
            }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
            if mediator.duelList.isEmpty {
                mediator.getMyDuels(withClear: true, page: 0) { }
            }
            ProfileMediator.shared.hasNewDuels = false
        }
    }
}
