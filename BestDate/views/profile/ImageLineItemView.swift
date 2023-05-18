//
//  ImageLineItemView.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct ImageLineItemView: View {
    @State var image: ProfileImage?
    var imageSize: CGFloat
    var showText: Bool = true

    var body: some View {
        ZStack {
            UpdateImageView(image: $image)
                .frame(width: imageSize, height: imageSize)
        }.frame(width: imageSize, height: imageSize, alignment: .bottom)
    }
}
