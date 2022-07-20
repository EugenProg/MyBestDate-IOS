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

                    Button(action: {
                        
                    }) {
                        Image("ic_menu_dots")
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                    }
                }

                Title(textColor: ColorList.white.color, text: "guests", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 0, bottom: 16, trailing: 0))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)
                .shadow(color: MyColor.getColor(0, 0, 0, 0.16), radius: 6, y: 3)
            if mediator.newGuests.isEmpty && mediator.oldGuests.isEmpty {
                let topPadding = ((UIScreen.main.bounds.height - 260 - store.state.statusBarHeight) / 2) - 100
                NoDataView()
                    .padding(.init(top: topPadding, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {

                        if !mediator.newGuests.isEmpty {
                            GuestListView(title: "new_guests", list: $mediator.newGuests) { guest in
                                AnotherProfileMediator.shared.setUser(user: guest.guest ?? UserInfo())
                                store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                            }
                        }

                        if !mediator.oldGuests.isEmpty {
                            GuestListView(title: "previous_views", list: $mediator.oldGuests) { guest in
                                AnotherProfileMediator.shared.setUser(user: guest.guest ?? UserInfo())
                                store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 60, trailing: 0))
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                if mediator.oldGuests.isEmpty && mediator.newGuests.isEmpty {
                    mediator.getGuests()
                }
            }
    }
}

struct GuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GuestsScreen()
    }
}
