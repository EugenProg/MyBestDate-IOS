//
//  SearchScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct SearchScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = SearchMediator.shared
    var items: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3),
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3)]
    @ObservedObject var locationMediator = LocationMediator.shared
    @ObservedObject var onlineMediator = OnlineMediator.shared
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    MainHeaderImage()

                    Spacer()

                    Button(action: {
                        //store.dispatch(action: .navigate(screen: .PROFILE))
                    }) {
                        Image("ic_menu_dots")
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                    }
                }

                Title(textColor: ColorList.white.color, text: "search", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))

            HStack(spacing: 9) {
                DropDownView(style: .blue, text: $locationMediator.selectedItem) {
                    store.dispatch(action: .showBottomSheet(view: .MAIN_LOCATION))
                }

                DropDownView(style: .gray, text: $onlineMediator.selectedItem) {
                    store.dispatch(action: .showBottomSheet(view: .MAIN_ONLINE))
                }

                Spacer()

                Button(action: {

                }) {
                    ZStack {
                        Image("ic_button_decor")
                            .rotationEffect(Angle(degrees: 180))
                            .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))

                        Image("ic_settings")
                            .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 0))
                    }
                }
            }.frame(height: 60)
                .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 0))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: items, alignment: .center, spacing: 10,
                                pinnedViews: [.sectionHeaders, .sectionFooters]) {
                    ForEach(mediator.users, id: \.id) { user in
                        UserSearchItemView(user: user)
                    }
                }.padding(.init(top: 14, leading: 3, bottom: 45, trailing: 3))
            }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 60, trailing: 0))

        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            if mediator.users.isEmpty {
                mediator.getUserList()
            }
        }
    }
}
