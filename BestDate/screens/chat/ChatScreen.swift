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
    @State var sendTextProcess: Bool = false
    @State var translateProcess: Bool = false

    @State var isShowingPhotoLibrary = false
    @State var additionalHeight: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                HStack {
                    BackButton(style: .white) {
                        ChatListMediator.shared.getChatList()
                        mediator.messages.removeAll()
                        mediator.loadingMode = true
                        store.dispatch(action: .navigationBack)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text(mediator.user.name ?? "NONAME")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 18))

                        let visitTime = mediator.user.last_online_at?.toDate().getVisitPeriod() ?? ""

                        Text((mediator.user.is_online ?? false) ? "Online" : "Last visit \(visitTime)")
                            .foregroundColor((mediator.user.is_online ?? false) ? ColorList.green.color : ColorList.white_80.color)
                            .font(MyFont.getFont(.NORMAL, 14))
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

                }.frame(height: 55)
                    .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 32))

                Rectangle()
                    .fill(MyColor.getColor(190, 239, 255, 0.15))
                    .frame(height: 1)
            }
            .background(ColorList.main.color)

            if mediator.messages.isEmpty && !mediator.loadingMode {
                VStack {
                    InvitationChatView()
                }.frame(height: UIScreen.main.bounds.height)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    MessageListView(messageList: $mediator.messages) { item in
                        mediator.selectedMessage = item.message
                        store.dispatch(action: .showBottomSheet(view: .CHAT_ACTIONS))
                    }.padding(.init(top: 6, leading: 0, bottom: 16, trailing: 0))
                }.padding(.init(top: store.state.statusBarHeight + (mediator.editMode || mediator.replyMode ? 135 : 85) + additionalHeight, leading: 0, bottom: 90, trailing: 0))
                    .rotationEffect(Angle(degrees: 180))
            }

            ChatBottomView(text: $mediator.inputText,
                           sendTextProcess: $sendTextProcess,
                           translateProcess: $translateProcess,
                           additionalHeight: $additionalHeight,
                           editMode: $mediator.editMode,
                           replyMode: $mediator.replyMode,
                           selectedMessage: $mediator.selectedMessage,
                loadImageAction: {
                    withAnimation { isShowingPhotoLibrary.toggle() }
                },
                translateAction: { text in
                    translateProcess.toggle()
                },
                sendAction: { text in
                    mediator.saveMessage(message: text) { success in
                        DispatchQueue.main.async {
                            sendTextProcess.toggle()
                            if success { mediator.inputText = "" }
                        }
                    }
                })
                .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
                .edgesIgnoringSafeArea(.bottom)
        }.background(Image("bg_chat_decor").edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
        .sheet(isPresented: $isShowingPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary,
                        isSelectAction: { image in
                /*let message = inputText.isEmpty ? nil : inputText
                mediator.sendImageMessage(image: image, message: message) { _ in

                }*/
            })
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
