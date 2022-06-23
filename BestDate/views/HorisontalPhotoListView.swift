//
//  HorisontalPhotoListView.swift
//  BestDate
//
//  Created by Евгений on 14.06.2022.
//

import SwiftUI

struct HorisontalPhotoListView: View {
    
    var imageSize = (UIScreen.main.bounds.width - 12) / 3
    @Binding var imagesList: [UIImage]
    var selectAction: (UIImage) -> Void
    
    fileprivate func imageListView(clickAction: @escaping (UIImage) -> Void) -> some View {
        HStack(spacing: 3) {
            ForEach(imagesList, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .onTapGesture {
                        clickAction(image)
                    }
            }
        }.padding(.init(top: 0, leading: 3, bottom: 0, trailing: 3))
    }
    
    var body: some View {
        ZStack {
            if imagesList.count <= 3 {
                HStack(spacing: 3) {
                    Rectangle().fill(ColorList.white_10.color)
                    Rectangle().fill(ColorList.white_10.color)
                    Rectangle().fill(ColorList.white_10.color)
                }.frame(height: imageSize)
                .padding(.init(top: 0, leading: 3, bottom: 0, trailing: 3))
                
                imageListView { image in selectAction(image) }
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    imageListView { image in selectAction(image) }
                }
            }
        }.padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))
    }
}