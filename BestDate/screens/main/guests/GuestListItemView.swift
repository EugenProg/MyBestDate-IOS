//
//  GuestListItemView.swift
//  BestDate
//
//  Created by Евгений on 18.07.2022.
//

import SwiftUI

struct GuestListItemView: View {
    var guest: Guest

    var body: some View {
        ZStack {
            Rectangle()
                .fill(MyColor.getColor(41, 50, 54))

            HStack(spacing: 14) {
                AsyncImageView(url: guest.guest?.main_photo?.thumb_url)
                    .frame(width: 64, height: 64)

                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 0) {
                        Text(guest.guest?.name ?? "Noname")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 16))

                        Image((guest.guest?.full_questionnaire ?? false) ? "ic_verify_active" : "ic_verify_gray")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 0))

                        Text("\(guest.guest?.getAge() ?? 18)")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 16))
                            .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 0))

                        Text("y")
                            .foregroundColor(ColorList.white_80.color)
                            .font(MyFont.getFont(.BOLD, 10))
                            .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                    }

                    Text(guest.guest?.getLocation() ?? "")
                        .foregroundColor(ColorList.white_40.color)
                        .font(MyFont.getFont(.NORMAL, 12))

                    HStack(spacing: 4) {
                        Image("ic_time")

                        Text(NSLocalizedString("visited", comment: "visited"))
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 12))

                        Text(guest.getVisitedPeriod())
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 12))
                            .padding(.init(top: 0, leading: 3, bottom: 0, trailing: 0))
                    }
                }

                Spacer()

                if !(guest.viewed ?? false) {
                    VStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(LinearGradient(gradient: Gradient(colors: [
                                    MyColor.getColor(48, 58, 62),
                                    MyColor.getColor(43, 52, 56)
                                ]), startPoint: .leading, endPoint: .trailing))

                            HStack(spacing: 6) {
                                Text(NSLocalizedString("new_visit", comment: "New visit"))
                                    .foregroundColor(ColorList.white.color)
                                    .font(MyFont.getFont(.NORMAL, 10))

                                RoundedRectangle(cornerRadius: 4)
                                    .fill(MyColor.getColor(240, 89, 221))
                                    .frame(width: 8, height: 8)
                            }
                        }.frame(width: 67, height: 20)
                    }.padding(.init(top: 8, leading: 0, bottom: 7, trailing: 0))
                }
            }
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 13))
        }.frame(height: 84)
    }
}
