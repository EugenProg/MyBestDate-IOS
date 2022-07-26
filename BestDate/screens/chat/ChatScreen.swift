//
//  ChatScreen.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import SwiftUI

struct ChatScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = ChatMediator.shared
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                HStack {
                    BackButton(style: .white) {
                        AnotherProfileMediator.shared.setUser(user: mediator.user)
                        store.dispatch(action: .navigationBack)
                    }

                    Spacer()

                    VStack {
                        Text(mediator.user.name ?? "NONAME")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 18))
                    }.padding(.init(top: 0, leading: 5, bottom: 0, trailing: 18))

                    ZStack {
                        AsyncImageView(url: mediator.user.main_photo?.thumb_url)
                            .clipShape(Circle())

                        if mediator.user.is_online ?? false {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(ColorList.main.color)

                                RoundedRectangle(cornerRadius: 4)
                                    .fill(ColorList.green.color)
                                    .frame(width: 8, height: 8)
                            }.frame(width: 12, height: 12)
                                .padding(.init(top: 33, leading: 33, bottom: 0, trailing: 0))
                        }
                    }.frame(width: 45, height: 45, alignment: .bottomTrailing)
                        .onTapGesture {
                            goToUserProfile()
                        }

                }.frame(height: 60)
                    .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 32))

                Rectangle()
                    .fill(MyColor.getColor(190, 239, 255, 0.15))
                    .frame(height: 1)
            }
            .background(ColorList.main.color)

            ScrollView(.vertical, showsIndicators: true) {
                ForEach(0...15, id: \.self) {_ in
                    RoundedRectangle(cornerRadius: 28)
                        .fill(ColorList.white.color)
                        .frame(height: 50)
                        .padding(.init(top: 5, leading: 18, bottom: 5, trailing: 18))
                }
            }.padding(.init(top: 94, leading: 0, bottom: store.state.statusBarHeight + 60, trailing: 0))

            ChatBottomView(
                loadImageAction: {

                },
                translateAction: {

                },
                sendAction: {
                    
                })
                .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
                .edgesIgnoringSafeArea(.bottom)
        }.background(Image("bg_chat_decor").edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }

    private func goToUserProfile() {
        AnotherProfileMediator.shared.setUser(user: mediator.user)
        if store.state.screenStack.last == .ANOTHER_PROFILE {
            withAnimation {
                store.dispatch(action: .navigationBack)
            }
        } else {
            withAnimation {
                store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
            }
        }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}
