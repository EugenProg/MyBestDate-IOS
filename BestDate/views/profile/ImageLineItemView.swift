//
//  ImageLineItemView.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct ImageLineItemView: View {
    var image: ProfileImage
    var imageSize: CGFloat

    var body: some View {
        ZStack {
            AsyncImageView(url: image.full_url)
                .frame(width: imageSize, height: imageSize)

            VStack {
                Spacer()
                ZStack {
                    OverlayView(reverse: true)

                    HStack {
                        if (image.match ?? false) {
                            Text(NSLocalizedString("sympathy", comment: "sympathy"))
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.NORMAL, 14))
                                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                        }

                        Spacer()

                        if (image.top ?? false) {
                            Text(NSLocalizedString("top_50", comment: "top"))
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.NORMAL, 14))
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                        }
                    }
                }.frame(width: imageSize, height: 26)
            }
        }.frame(width: imageSize, height: imageSize, alignment: .bottom)
    }
}
