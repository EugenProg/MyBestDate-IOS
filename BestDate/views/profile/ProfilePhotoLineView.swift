//
//  ProfilePhotoLineView.swift
//  BestDate
//
//  Created by Евгений on 16.07.2022.
//

import SwiftUI

struct ProfilePhotoLineView: View {
    var imageSize = (UIScreen.main.bounds.width - 42) / 3
    @Binding var imagesList: [ProfileImage]
    var addAction: () -> Void
    var selectAction: (ProfileImage) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 3) {
                ForEach(imagesList, id: \.id) { image in
                    ImageLineItemView(image: image, imageSize: imageSize)
                        .onTapGesture {
                            selectAction(image)
                        }
                }
                
                if imagesList.count < 9 {
                    AddImageButton(height: imageSize) {
                        addAction()
                    }
                }
                Spacer()
            }
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
        }
    }
}

