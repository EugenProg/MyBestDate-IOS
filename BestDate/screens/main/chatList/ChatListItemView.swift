//
//  ChatListItemView.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import SwiftUI

struct ChatListItemView: View {
    @Binding var item: Chat
    @Binding var typingMode: Bool
    @Binding var isOnline: Bool
    var type: ChatItemType

    @Binding var deleteProccess: Bool
    @State var offset: CGFloat = 0

    var deleteAction: (Chat) -> Void
    var clickAction: (Chat) -> Void

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Button(action: {
                    if !deleteProccess {
                        withAnimation {
                            deleteProccess = true
                            deleteAction(item)
                            offset = 0
                        }
                    }
                }) {
                    ZStack {
                        Image("ic_delete")
                            .resizable()
                            .frame(width: 16, height: 17)
                    }.frame(width: 78, height: 78)
                        .background(ColorList.red.color)
                        .padding(.init(top: 0, leading: 2, bottom: 0, trailing: 2))
                }
            }

            ZStack {
                Rectangle()
                    .fill(MyColor.getColor(28, 38, 43))

                HStack(spacing: 0) {
                    ZStack {
                        UserImageView(user: $item.user)
                            .clipShape(Circle())

                        if isOnline {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(ColorList.main.color)

                                RoundedRectangle(cornerRadius: 5)
                                    .fill(ColorList.green.color)
                                    .frame(width: 9, height: 9)
                            }.frame(width: 14, height: 14)
                                .padding(.init(top: 37, leading: 37, bottom: 0, trailing: 0))
                        }
                    }.frame(width: 52, height: 52)

                    VStack(alignment: .leading, spacing: 7) {
                        Text(item.user?.name ?? "NONAME")
                            .foregroundColor(type.nameColor)
                            .font(MyFont.getFont(.BOLD, 20))

                        if typingMode {
                            Text("typing".localized())
                                .foregroundColor(ColorList.green.color)
                                .font(MyFont.getFont(.NORMAL, 18))
                                .opacity(type.typingOpacity)
                        } else if item.last_message?.image != nil {
                            HStack {
                                Image("ic_picture")
                                    .resizable()
                                    .opacity(0.8)
                                    .frame(width: 14, height: 14)

                                Text("Photo")
                                    .foregroundColor(type.messageColor)
                                    .font(MyFont.getFont(.NORMAL, 18))
                            }
                        } else if item.last_message?.text != nil {
                            Text(item.last_message?.text ?? "")
                                .foregroundColor(type.messageColor)
                                .font(MyFont.getFont(.NORMAL, 18))
                                .lineLimit(1)
                        }
                    }.padding(.init(top: 0, leading: 17, bottom: 0, trailing: 0))
                    Spacer()

                    VStack(alignment: .trailing, spacing: 12) {
                        Text(item.getLastMessageTime())
                            .foregroundColor(ColorList.white_80.color)
                            .font(MyFont.getFont(.NORMAL, 16))

                        if type == .new {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(ColorList.main.color)
                                    .frame(width: 14, height: 14)

                                RoundedRectangle(cornerRadius: 5)
                                    .fill(ColorList.pink.color)
                                    .frame(width: 10, height: 10)
                            }
                        } else {
                            Image(getStatusIcon())
                        }
                    }
                }.padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))

            }.offset(x: offset, y: 0)
                .gesture(dragGesture)

        }.frame(height: 80)
            .onTapGesture { withAnimation { clickAction(item) } }
    }

    private func getStatusIcon() -> String {
        item.last_message?.read_at == nil ? "ic_message_un_checked" : "ic_message_checked"
    }

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let width = value.translation.width
                if width <= 0 && !deleteProccess { offset = width }
            }
            .onEnded { value in
                withAnimation {
                    if value.translation.width < -82 {
                        offset = -82
                    } else {
                        offset = 0
                    }
                }
            }
    }
}

struct ChatBotItemView: View {
    @Binding var item: Chat
    var type: ChatItemType

    var clickAction: (Chat) -> Void

    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(MyColor.getColor(28, 38, 43))

                HStack(spacing: 0) {
                    Image("icon")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 52, height: 52)

                    VStack(alignment: .leading, spacing: 7) {
                        Text(item.user?.name ?? "NONAME")
                            .foregroundColor(type.nameColor)
                            .font(MyFont.getFont(.BOLD, 20))

                        if item.last_message?.image != nil {
                            HStack {
                                Image("ic_picture")
                                    .resizable()
                                    .opacity(0.8)
                                    .frame(width: 14, height: 14)

                                Text("Photo")
                                    .foregroundColor(type.messageColor)
                                    .font(MyFont.getFont(.NORMAL, 18))
                            }
                        } else if item.last_message?.text != nil {
                            Text(item.last_message?.text ?? "")
                                .foregroundColor(type.messageColor)
                                .font(MyFont.getFont(.NORMAL, 18))
                                .lineLimit(1)
                        }
                    }.padding(.init(top: 0, leading: 17, bottom: 0, trailing: 0))
                    Spacer()

                    VStack(alignment: .trailing, spacing: 12) {
                        Text(item.getLastMessageTime())
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 16))

                        if type == .new {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(ColorList.main.color)
                                    .frame(width: 14, height: 14)

                                RoundedRectangle(cornerRadius: 5)
                                    .fill(ColorList.pink.color)
                                    .frame(width: 10, height: 10)
                            }
                        } else {
                            Image(getStatusIcon())
                        }
                    }
                }.padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
            }
        }.frame(height: 80)
            .onTapGesture { withAnimation { clickAction(item) } }
    }

    private func getStatusIcon() -> String {
        item.last_message?.read_at == nil ? "ic_message_un_checked" : "ic_message_checked"
    }
}

enum ChatItemType {
    case new
    case old

    var nameColor: Color {
        switch self {
        case .new: return ColorList.white_90.color
        case .old: return ColorList.white_60.color
        }
    }

    var messageColor: Color {
        switch self {
        case .new: return ColorList.white_90.color
        case .old: return ColorList.white_30.color
        }
    }

    var typingOpacity: Double {
        switch self {
        case .new: return 0.9
        case .old: return 0.6
        }
    }
}
