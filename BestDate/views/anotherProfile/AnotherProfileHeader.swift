//
//  AnotherProfileHeader.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct AnotherProfileHeader: View {
    @EnvironmentObject var store: Store

    var image: ProfileImage
    var isOnline: Bool
    var birthday: String

    var body: some View {
        ZStack {
            AsyncImageView(url: image.full_url)
                .cornerRadius(radius: 33, corners: [.bottomLeft, .bottomRight])
                .frame(height: UIScreen.main.bounds.width)

            OverlayView()

            VStack {
                VStack(spacing: 0) {
                    HStack {
                        BackButton(style: .white)

                        Spacer()

                        Button(action: {

                        }) {
                            Image("ic_menu_dots")
                                .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                        }
                    }.padding(.init(top: store.state.statusBarHeight + 16, leading: 32, bottom: 0, trailing: 32))

                    Spacer()

                    ZStack {
                        OverlayView(reverse: true)
                        HStack {
                            if isOnline {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(ColorList.green.color)
                                    .frame(width: 12, height: 12)
                            }

                            Text("3.1 Miles")
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.NORMAL, 14))

                            Spacer()

                            Text(NSLocalizedString(birthday.toDate().getZodiacSign(), comment: "Zodiak"))
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.NORMAL, 14))
                        }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))
                    }.frame(height: 46)
                }.frame(height: UIScreen.main.bounds.width)
            }.frame(height: UIScreen.main.bounds.width)
        }
    }
}

