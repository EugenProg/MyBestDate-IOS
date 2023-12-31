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
    @ObservedObject var pickerMediator = ImagePickerMediator.shared
    @ObservedObject var networkManager = NetworkManager.shared
    @State private var offsetValue: CGFloat = 0.0

    @State var sendTextProcess: Bool = false
    @State var translateProcess: Bool = false

    @State var additionalHeight: CGFloat = 0

    @State var showImage: Bool = false
    @State var showingImage: ChatImage? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            if !mediator.messages.isEmpty && mediator.user?.getRole() != .bot {
                TopPanelView(offsetValue: $offsetValue) {
                    openInvitationDialog()
                }
            }

            VStack(spacing: 0) {
                HStack {
                    BackButton(style: .white) {
                        ChatListMediator.shared.getChatList(withClear: true, page: 0)
                        mediator.messages.removeAll()
                        mediator.typingMode = false
                        withAnimation {
                            store.dispatch(action: .navigationBack)
                        }
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text(mediator.user?.name ?? "NONAME")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 18))

                        if mediator.user?.getRole() == .user {
                            let visitTime = mediator.user?.last_online_at?.toDate().getVisitPeriod() ?? ""
                            let lastVisit = "\("last_visit".localized()) \(visitTime)"
                            let text = mediator.isOnline ? "Online" : lastVisit

                            Text(mediator.typingMode ? "typing".localized() : text)
                                .foregroundColor(mediator.isOnline ? ColorList.green.color : ColorList.white_80.color)
                                .font(MyFont.getFont(.NORMAL, 14))
                        }
                    }.padding(.init(top: 0, leading: 5, bottom: 0, trailing: 18))
                        .onTapGesture {
                            if mediator.user?.getRole() == .user {
                                goToUserProfile()
                            }
                        }

                    if mediator.user?.getRole() == .bot {
                        Image("icon")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 45, height: 45)
                    } else {
                        ZStack {
                            UserImageView(user: $mediator.user)
                                .clipShape(Circle())

                            if mediator.isOnline {
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
                    }
                }.frame(height: 55)
                    .padding(.init(top: 16 + (offsetValue / 2), leading: 32, bottom: 16, trailing: 32))

                Rectangle()
                    .fill(MyColor.getColor(190, 239, 255, 0.15))
                    .frame(height: 1)
            }
            .background(ColorList.main.color)

            if mediator.messages.isEmpty && !mediator.loadingMode {
                VStack {
                    InvitationChatView(onlyCards: $mediator.cardsOnlyMode) {
                        openInvitationDialog()
                    }
                }.frame(height: UIScreen.main.bounds.height)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        if mediator.showChatClosedView {
                            MessagesBlockedView {
                                store.dispatch(action: .navigate(screen: .SETTINGS))
                            }.rotationEffect(Angle(degrees: 180))
                        }

                        MessageListView(messageList: $mediator.messages, meta: $mediator.meta) { item in
                            if mediator.user?.getRole() != .bot {
                                mediator.selectedMessage = item.message
                                store.dispatch(action: .showBottomSheet(view: .CHAT_ACTIONS))
                            }
                        } imageClick: { image in
                            showingImage = image
                            showImage = true
                        } loadNextPage: {
                            mediator.getNextPage()
                        } translateClick: { message in
                            mediator.translateMessage(message: message)
                        }.padding(.init(top: 6, leading: 0, bottom: 16, trailing: 0))
                    }
                }.padding(.init(top: getTopPadding(), leading: 0, bottom: getBottomPadding(), trailing: 0))
                    .rotationEffect(Angle(degrees: 180))
            }

            if mediator.user?.getRole() == .user {
                if mediator.cardsOnlyMode {
                    ChatOnlyCardBottomView(user: mediator.user)
                        .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
                        .edgesIgnoringSafeArea(.bottom)
                } else {
                    VStack {
                        Spacer()

                        ChatBottomView(text: $mediator.inputText,
                                       sendTextProcess: $sendTextProcess,
                                       translateProcess: $translateProcess,
                                       additionalHeight: $additionalHeight,
                                       editMode: $mediator.editMode,
                                       replyMode: $mediator.replyMode,
                                       selectedMessage: $mediator.selectedMessage,
                                       loadImageAction: {
                            pickerMediator.isShowingPhotoLibrary.toggle()
                        }, translateAction: { text in
                            mediator.translate(text: text) { success, translatedText in
                                DispatchQueue.main.async {
                                    translateProcess.toggle()
                                    if success { mediator.inputText = translatedText }
                                }
                            }
                        }, sendAction: { text in
                            if UserDataHolder.shared.messageSendAllowed() {
                                mediator.saveMessage(message: text) { success in
                                    DispatchQueue.main.async {
                                        sendTextProcess.toggle()
                                        if success { mediator.inputText = "" }
                                    }
                                }
                            } else {
                                sendTextProcess.toggle()
                                store.dispatch(action: .showMessageBunningDialog)
                            }
                        })
                        .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
                    }.keyboardSensible($offsetValue)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }

            ChatImageViewer()
                .opacity(mediator.editImageMode ? 1 : 0)
                .offset(y: mediator.editImageMode ? 0 : UIScreen.main.bounds.height)

            ChatImageShowView(image: $showingImage, show: $showImage)
                .opacity(showImage ? 1 : 0)
                .scaleEffect(showImage ? 1 : 0)
        }
        .background(
            Image("bg_chat_decor")
                .resizable()
        ).edgesIgnoringSafeArea(.bottom)
            .onChange(of: networkManager.isConnected, perform: { newValue in
                if newValue {
                    mediator.getMessageList(withClear: true, page: 0)
                }
            })
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))

                mediator.showMessage = { message in
                    store.dispatch(action: .show(message: message))
                }
            }
            .sheet(isPresented: $pickerMediator.isShowingPhotoLibrary) {
                ImagePicker { image in
                    mediator.selectedImage = image
                    mediator.editImageMode.toggle()
                }
            }
    }

    private func goToUserProfile() {
        AnotherProfileMediator.shared.setUser(user: mediator.user ?? ShortUserInfo())
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

    private func openInvitationDialog() {
        if UserDataHolder.shared.invitationSendAllowed() {
            CreateInvitationMediator.shared.setUser(user: mediator.user ?? ShortUserInfo())
            store.dispatch(action: .createInvitation)
        } else {
            store.dispatch(action: .showInvitationBunningDialog)
        }
    }

    private func getTopPadding() -> CGFloat { //Its the bottom padding, becose the view is rotate at 180 degree
        var bottomBoxHeight = (mediator.editMode || mediator.replyMode ? 135 : 85) + additionalHeight + offsetValue
        if mediator.user?.getRole() != .user { bottomBoxHeight = 16 }
        else if mediator.cardsOnlyMode { bottomBoxHeight = 150 }
        return store.state.statusBarHeight + bottomBoxHeight
    }

    private func getBottomPadding() -> CGFloat {//Its the top padding, becose the view is rotate at 180 degree
        (offsetValue / 2) + 90 + ((mediator.messages.isEmpty || mediator.user?.getRole() == .bot) ? 0 : 41)
    }
}
