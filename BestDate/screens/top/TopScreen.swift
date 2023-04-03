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
                    BackButton(style: .white) {
                        mediator.manSavedPosition = 0
                        mediator.womanSavedPosition = 0
                        store.dispatch(action: .navigationBack)
                    }

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

            if mediator.activePage == .man {
                TopListView(list: $mediator.manTopList, meta: $mediator.manListMeta, loadingMode: $mediator.manLoadingMode,
                            savedPosition: $mediator.manSavedPosition, offsetChanged: savePosition()) { user in
                    AnotherProfileMediator.shared.setUser(user: user)
                    store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                } loadNextPage: {
                    mediator.getManNextPage()
                }.transition(.move(edge: .trailing))
                    .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
            } else {
                TopListView(list: $mediator.womanTopList, meta: $mediator.womanListMeta, loadingMode: $mediator.womanLoadingMode,
                            savedPosition: $mediator.womanSavedPosition, offsetChanged: savePosition()) { user in
                    AnotherProfileMediator.shared.setUser(user: user)
                    store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                } loadNextPage: {
                    mediator.getWomanNextPage()
                }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
    }

    func savePosition() -> (CGFloat) -> Void {
        { position in
            mediator.savePosition(position)
        }
    }
}
