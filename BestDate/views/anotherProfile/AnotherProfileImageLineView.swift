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
    @Binding var imagesCount: Int
    var selectAction: (Int) -> Void

    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 3) {
                    if imagesList.isEmpty && imagesCount > 0 {
                        ForEach(1...imagesCount, id: \.self) { index in
                            ZStack {
                                Rectangle()
                                    .fill(ColorList.white_10.color)

                                LoadingDotsView()
                            }.frame(width: imageSize, height: imageSize)
                        }
                    } else {
                        ForEach(imagesList.indices, id: \.self) { index in
                            ImageLineItemView(image: imagesList[index], imageSize: imageSize, showText: false)
                                .onTapGesture {
                                    print(">>> index: \(index)")
                                    selectAction(index)
                                }
                        }
                    }
                    Spacer()
                }.padding(.init(top: 0, leading: 3, bottom: 0, trailing: 3))
            }
        }.padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))
    }
}
