//
//  ChatListItemView.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import SwiftUI

struct ChatListItemView: View {
    var item: Chat
    var type: ChatItemType
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(MyColor.getColor(28, 38, 43))

            HStack(spacing: 0) {
                ZStack {
                    AsyncImageView(url: item.user?.main_photo?.thumb_url)
                        .clipShape(Circle())

                    if item.user?.is_online ?? false {
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

                    Text(item.last_message?.text ?? "Tell me how you are and how was your day")
                        .foregroundColor(type.messageColor)
                        .font(MyFont.getFont(.NORMAL, 18))
                        .lineLimit(1)
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

        }.frame(height: 80)
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
}
