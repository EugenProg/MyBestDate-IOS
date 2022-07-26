//
//  VoiterInfoView.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import SwiftUI

struct VoiterInfoView: View {
    var voter: ShortUserInfo
    var voteTime: String

    var body: some View {
        ZStack {
            Rectangle()
                .fill(MyColor.getColor(41, 50, 54))

            HStack(spacing: 14) {
                AsyncImageView(url: voter.main_photo?.thumb_url)
                    .frame(width: 64, height: 64)

                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 0) {
                        Text(voter.name ?? "Noname")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 16))

                        Image((voter.full_questionnaire ?? false) ? "ic_verify_active" : "ic_verify_gray")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 0))

                        Text("\(voter.getAge())")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 16))
                            .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 0))

                        Text("y")
                            .foregroundColor(ColorList.white_80.color)
                            .font(MyFont.getFont(.BOLD, 10))
                            .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                    }

                    Text(voter.occupation ?? "Loser")
                        .foregroundColor(ColorList.white_40.color)
                        .font(MyFont.getFont(.NORMAL, 12))

                    HStack(spacing: 4) {
                        Image("ic_time")

                        Text(NSLocalizedString("you_where_voted_for", comment: "voted Time"))
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 12))

                        Text(voteTime)
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 12))
                            .padding(.init(top: 0, leading: 3, bottom: 0, trailing: 0))
                    }
                }

                Spacer()
            }
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 13))
        }.frame(height: 84)
    }
}
