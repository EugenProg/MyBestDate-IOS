//
//  MyDuelsListItemView.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import SwiftUI

struct MyDuelsListItemView: View {
    var item: MyDuel

    var clickVoiter: (ShortUserInfo) -> Void
  // var clickLoser: (Int) -> Void

    var body: some View {
        let size = (UIScreen.main.bounds.width - 9) / 2
        ZStack {
            VStack(spacing: 0) {

                HStack(spacing: 3) {
                    AsyncImageView(url: item.winning_photo?.thumb_url)
                        .frame(width: size, height: size)

                    AsyncImageView(url: item.loser_photo?.thumb_url)
                        .frame(width: size, height: size)
                        .onTapGesture {
                           // clickLoser()
                        }
                }.padding(.init(top: 0, leading: 3, bottom: 0, trailing: 3))

                VoiterInfoView(voter: item.voter ?? ShortUserInfo(), voteTime: item.getVisitedPeriod())
                    .onTapGesture {
                        withAnimation { clickVoiter(item.voter ?? ShortUserInfo()) }
                    }
            }

            HStack(alignment: .bottom, spacing: 0) {
                ZStack {
                    Image("bg_left_rectangle")

                    HStack(spacing: 15) {
                        Image("ic_winner")
                            .padding(.init(top: 0, leading: 0, bottom: 15, trailing: 0))

                        Text(NSLocalizedString("winner", comment: "Winner").uppercased())
                            .foregroundColor(ColorList.light_blue.color)
                            .font(MyFont.getFont(.BOLD, 10))
                    }.padding(.init(top: 0, leading: 0, bottom: 5, trailing: 24))
                }

                Spacer()

                ZStack {
                    Image("bg_top_rectangle")
                        .resizable()
                        .frame(width: 151, height: 36)

                    DuelColorfullTitle()
                        .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
                }.padding(.init(top: 0, leading: 0, bottom: 9, trailing: 0))

                Spacer()

                ZStack {
                    Image("bg_right_rectangle")

                    HStack(spacing: 15) {
                        Text(NSLocalizedString("loser", comment: "Loser").uppercased())
                            .foregroundColor(ColorList.pink.color)
                            .font(MyFont.getFont(.BOLD, 10))

                        Image("ic_loser")
                            .padding(.init(top: 0, leading: 0, bottom: 15, trailing: 0))
                    }.padding(.init(top: 0, leading: 24, bottom: 5, trailing: 0))
                }
            }.padding(.init(top: size - 40, leading: 0, bottom: 87, trailing: 0))
        }
    }
}
