//
//  GuestsScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct GuestsScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = GuestsMediator.shared
    
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
                }

                Title(textColor: ColorList.white.color, text: "guests", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 0, bottom: 16, trailing: 0))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)
                .shadow(color: MyColor.getColor(0, 0, 0, 0.16), radius: 6, y: 3)
            
            if mediator.newGuests.isEmpty && mediator.oldGuests.isEmpty {
                NoDataBoxView(loadingMode: $mediator.loadingMode, text: "you_have_no_guests_yet")
                    .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
                Spacer()
            } else {
                RefreshScrollView(onRefresh: { done in
                    mediator.getGuests(withClear: true, page: 0) { done() }
                }) {
                    VStack(alignment: .leading, spacing: 0) {
                        if !mediator.newGuests.isEmpty {
                            GuestListView(title: "new_guests", list: $mediator.newGuests, meta: $mediator.meta,
                                          lastItemId: $mediator.lastGuestId) { guest in
                                AnotherProfileMediator.shared.setUser(user: guest.guest ?? ShortUserInfo())
                                store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                            } loadNextPage: {
                                mediator.getNextPage()
                            }
                        }

                        if !mediator.oldGuests.isEmpty {
                            GuestListView(title: "previous_views", list: $mediator.oldGuests, meta: $mediator.meta,
                                          lastItemId: $mediator.lastGuestId) { guest in
                                AnotherProfileMediator.shared.setUser(user: guest.guest ?? ShortUserInfo())
                                store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                            } loadNextPage: {
                                mediator.getNextPage()
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.init(top: 0, leading: 0, bottom: 45, trailing: 0))
                }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 60, trailing: 0))
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                if mediator.oldGuests.isEmpty && mediator.newGuests.isEmpty {
                    mediator.getGuests(withClear: true, page: 0) { }
                }
                MainMediator.shared.hasNewGuests = false
            }
    }
}

struct GuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GuestsScreen()
    }
}
