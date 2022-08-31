//
//  ChatListScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct ChatListScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = ChatListMediator.shared
    @State var deleteProcess: Bool = false
    
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

                Title(textColor: ColorList.white.color, text: "chats", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 0, bottom: 16, trailing: 0))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: false) {
                ChatListView(newList: $mediator.newChats,
                             previousList: $mediator.previousChats,
                             deleteProcess: $deleteProcess,
                             loadingMode: $mediator.loadingMode,
                             deleteAction: delete()) { chat in
                    ChatMediator.shared.setUser(user: chat.user ?? ShortUserInfo())
                    store.dispatch(action: .navigate(screen: .CHAT))
                }
                .padding(.init(top: 0, leading: 0, bottom: 45, trailing: 0))
            }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 60, trailing: 0))
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                if mediator.newChats.isEmpty && mediator.previousChats.isEmpty {
                    mediator.getChatList()
                }

                MainMediator.shared.chatListPage = {
                    mediator.getChatList()
                }
            }
    }

    private func delete() -> (Chat) -> Void {
        { chat in
            mediator.delete(chat: chat) {
                deleteProcess = false
            }
        }
    }
}

struct ChatListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatListScreen()
    }
}
