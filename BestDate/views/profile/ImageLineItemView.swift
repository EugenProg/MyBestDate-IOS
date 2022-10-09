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
    var showText: Bool = true

    var body: some View {
        ZStack {
            AsyncImageView(url: image.thumb_url)
                .frame(width: imageSize, height: imageSize)

            if showText {
                VStack {
                    Spacer()
                    ZStack(alignment: .leading) {
                        OverlayView(reverse: true)
                        
                        if (image.top ?? false) {
                            Text(NSLocalizedString("top_50", comment: "top"))
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.NORMAL, 14))
                                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        }
                    }.frame(width: imageSize, height: 26)
                }
            }
        }.frame(width: imageSize, height: imageSize, alignment: .bottom)
    }
}
