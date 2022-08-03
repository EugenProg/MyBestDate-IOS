//
//  TopListItemView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct TopListItemView: View {

    var item: Top
    var place: Int

    var body: some View {
        ZStack {
            AsyncImageView(url: item.thumb_url)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))

            VStack(alignment: .leading, spacing: 0) {
                Spacer()

                ZStack {
                    Image("bg_top_rectangle")
                        .resizable()

                    HStack(spacing: 1) {
                        Image(getTopStarsIcon())

                        Image(getTopMedalIcon())

                        Text("№\(place.toString())")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 16))
                            .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 0))

                        Spacer()

                        Text(item.rating?.printPercent() ?? "")
                            .foregroundColor(ColorList.white_80.color)
                            .font(MyFont.getFont(.BOLD, 16))

                        Text("%")
                            .foregroundColor(ColorList.white_80.color)
                            .font(MyFont.getFont(.BOLD, 10))
                            .padding(.init(top: 3, leading: 0, bottom: 0, trailing: 3))
                    }
                    .padding(.init(top: 0, leading: 10, bottom: 5, trailing: 10))
                }.frame(width: (UIScreen.main.bounds.width - 9) / 2, height: 36)
            }
        }.frame(height: ((UIScreen.main.bounds.width - 9) / 2) + 20)
    }

    private func getTopStarsIcon() -> String {
        switch place {
        case 1: return "ic_gold_stars"
        case 2: return "ic_silver_stars"
        case 3: return "ic_bronze_stars"
        default: return "ic_unactive_stars"
        }
    }

    private func getTopMedalIcon() -> String {
        switch place {
        case 1: return "ic_gold_medal"
        case 2: return "ic_silver_medal"
        case 3: return "ic_bronze_medal"
        default: return "ic_white_medal"
        }
    }
}
