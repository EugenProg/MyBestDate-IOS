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
    @ObservedObject var locationMediator = LocationMediator.shared
    @ObservedObject var onlineMediator = OnlineMediator.shared
    @State var refreshingProcess: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            store.dispatch(action: .navigate(screen: .PROFILE))
                        }
                    }) {
                        MainHeaderImage()
                    }

                    Spacer()

                    TextButton(text: mediator.selectedGender?.getName ?? FilterGender.all_gender.getName, textColor: ColorList.white.color) {
                        store.dispatch(action: .showBottomSheet(view: .MAIN_GENDER))
                    }
                }

                Title(textColor: ColorList.white.color, text: "search", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))

            HStack(spacing: 9) {
                DropDownView(style: .blue, text: $locationMediator.selectedItem.name) {
                    store.dispatch(action: .showBottomSheet(view: .MAIN_LOCATION))
                }

                DropDownView(style: .gray, text: $onlineMediator.selectedItem.name) {
                    store.dispatch(action: .showBottomSheet(view: .MAIN_ONLINE))
                }

                Spacer()

                Button(action: {
                    store.dispatch(action: .navigate(screen: .TARIFF_LIST))
                    //withAnimation { store.dispatch(action: .navigate(screen: .SEARCH_FILTER)) }
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

                SaveRefreshAndSetPositionScrollView(startPosition: mediator.savedPosition,
                                             offsetChanged: { mediator.savePosition($0) },
                                             onRefresh: { done in
                    refreshingProcess = true
                    mediator.getUserList(withClear: true, page: 0) {
                        refreshingProcess = false
                        done()
                    }
                }) {
                    if mediator.loadingMode && !refreshingProcess {
                        LoadingView()
                            .padding(.top, 50)
                    } else {
                        SearchListView(list: $mediator.users, meta: $mediator.meta) { user in
                            AnotherProfileMediator.shared.setUser(user: user)
                            store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                        } loadNextPage: {
                            mediator.getNextPage()
                        }
                        .padding(.init(top: 14, leading: 3, bottom: 45, trailing: 3))
                    }
                }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 60, trailing: 0))
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            if mediator.users.isEmpty {
                mediator.getUserList(withClear: true, page: 0) { }
            }
            MainMediator.shared.searchPage = {
                mediator.getUserList(withClear: true, page: 0) { }
            }
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
