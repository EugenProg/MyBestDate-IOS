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
    var distance: String

    var backAction: () -> Void
    var additionnallyAction: () -> Void

    var body: some View {
        ZStack {
            AsyncWithThumbImageView(thumbUrl: image.thumb_url, fullUrl: image.full_url)
                .cornerRadius(radius: 33, corners: [.bottomLeft, .bottomRight])
                .frame(height: UIScreen.main.bounds.width)

            OverlayView()

            VStack {
                VStack(spacing: 0) {
                    HStack {
                        BackButton(style: .white) {
                            store.dispatch(action: .navigationBack)
                            backAction()
                        }

                        Spacer()

                        Button(action: {
                            withAnimation { additionnallyAction() }
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

                            Text(distance)
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.NORMAL, 14))

                            Spacer()

                            Text(DateUtils().getZodiacSignByDate(birthdate: birthday).localized())
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.NORMAL, 14))
                        }.padding(.init(top: 50, leading: 32, bottom: 0, trailing: 32))
                    }.frame(height: 100)
                }.frame(height: UIScreen.main.bounds.width)
            }.frame(height: UIScreen.main.bounds.width)
        }
    }
}

