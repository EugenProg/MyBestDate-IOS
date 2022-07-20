//
//  AnotherProfileImageLineView.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct AnotherProfileImageLineView: View {
    var imageSize = (UIScreen.main.bounds.width - 12) / 3
    @Binding var imagesList: [ProfileImage]
    var selectAction: (ProfileImage) -> Void

    var body: some View {
        ZStack {
            if imagesList.count <= 3 {
                HStack(spacing: 3) {
                    Rectangle().fill(ColorList.white_10.color)
                    Rectangle().fill(ColorList.white_10.color)
                    Rectangle().fill(ColorList.white_10.color)
                }.frame(height: imageSize)
                .padding(.init(top: 0, leading: 3, bottom: 0, trailing: 3))

                HStack(spacing: 3) {
                    ForEach(imagesList, id: \.id) { image in
                        ImageLineItemView(image: image, imageSize: imageSize)
                            .onTapGesture {
                                selectAction(image)
                            }
                    }
                    Spacer()
                }.padding(.init(top: 0, leading: 3, bottom: 0, trailing: 3))
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 3) {
                        ForEach(imagesList, id: \.id) { image in
                            ImageLineItemView(image: image, imageSize: imageSize)
                                .onTapGesture {
                                    selectAction(image)
                                }
                        }
                        Spacer()
                    }.padding(.init(top: 0, leading: 3, bottom: 0, trailing: 3))
                }
            }
        }.padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))
    }
}
