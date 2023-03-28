//
//  TopScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct TopScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = TopListMediator.shared
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: "top_50", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 0, trailing: 18))

            HStack {
                TopDropDownButtonView(style: mediator.activePage == .woman ? .pink : .blue, text: "universe".localized()) {
                    
                }

                Spacer()

                TopPagerToggle(activeType: $mediator.activePage)
            }.padding(.init(top: 0, leading: 18, bottom: 13, trailing: 18))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: false) {
                if mediator.manLoadingMode && mediator.manTopList.isEmpty && mediator.activePage == .man ||
                    mediator.womanLoadingMode && mediator.womanTopList.isEmpty && mediator.activePage == .woman {
                    ProgressView()
                        .tint(ColorList.white.color)
                        .frame(width: 80, height: 80)
                } else {
                    TopListView(page: $mediator.activePage,
                                womanList: $mediator.womanTopList,
                                manList: $mediator.manTopList) { user in
                        AnotherProfileMediator.shared.setUser(user: user)
                        store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                    }
                    .padding(.init(top: 14, leading: 3, bottom: 16, trailing: 3))
                }
            }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                mediator.getWomanList()
                mediator.getManList()
            }
    }
}
