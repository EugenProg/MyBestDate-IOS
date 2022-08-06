//
//  DuelCompareItem.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import SwiftUI

struct DuelCompareItem: View {
    @Binding var item: Top?
    @Binding var image: ProfileImage?

    var body: some View {
        ZStack {
            Rectangle()
                .fill(MyColor.getColor(41, 50, 54))

            HStack(spacing: 15) {
                UpdateImageView(image: $image)
                    .frame(width: 64, height: 64)

                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text(item?.user?.name ?? "Noname")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 16))

                        Image((item?.user?.full_questionnaire ?? false) ? "ic_verify_active" : "ic_verify_gray")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 0))

                        Text("\(item?.user?.getAge() ?? 18)")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 16))
                            .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 0))

                        Text("y")
                            .foregroundColor(ColorList.white_80.color)
                            .font(MyFont.getFont(.BOLD, 10))
                            .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                    }

                    Text(item?.user?.getLocation() ?? "")
                        .foregroundColor(ColorList.white_40.color)
                        .font(MyFont.getFont(.NORMAL, 12))
                        .padding(.init(top: 5, leading: 0, bottom: 8, trailing: 0))

                    HStack(spacing: 10) {
                        DuelProgressView(progress: item?.rating ?? 0)

                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(LinearGradient(gradient: Gradient(colors: [
                                    MyColor.getColor(48, 58, 62),
                                    MyColor.getColor(43, 52, 56)
                                ]), startPoint: .leading, endPoint: .trailing))

                            HStack(spacing: 2) {
                                Text(item?.rating?.printPercent() ?? "")
                                    .foregroundColor(ColorList.pink.color)
                                    .font(MyFont.getFont(.BOLD, 16))

                                Text("%")
                                    .foregroundColor(ColorList.pink.color)
                                    .font(MyFont.getFont(.BOLD, 10))
                                    .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                            }
                        }.frame(width: 67, height: 20)
                    }
                }
            }.padding(.init(top: 0, leading: 18, bottom: 0, trailing: 13))
        }.frame(width: UIScreen.main.bounds.width, height: 84)
            .padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
    }
}

