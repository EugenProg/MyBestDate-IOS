//
//  ImagesTabView.swift
//  BestDate
//
//  Created by Евгений on 06.08.2022.
//

import SwiftUI

struct ImagesTabView: View {
    var imagesCount: Int
    @Binding var selectedImage: Int
    var selectAction: () -> Void

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<imagesCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 3)
                    .fill(selectedImage == index ? ColorList.white_80.color : ColorList.white_40.color)
                    .padding(.init(top: 3, leading: 0, bottom: 2, trailing: 0))
                    .onTapGesture {
                        withAnimation {
                            if selectedImage != index {
                                selectedImage = index
                                selectAction()
                            }
                        }
                    }
            }
        }.frame(width: UIScreen.main.bounds.width - 64, height: 10)
    }
}
