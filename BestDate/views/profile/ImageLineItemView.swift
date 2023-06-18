//
//  ImageLineItemView.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct ImageLineItemView: View {
    @Binding var image: ProfileImage
    var imageSize: CGFloat
    var showText: Bool = true

    var body: some View {
        ZStack {
            UpdateProfileImageView(image: $image)
                .frame(width: imageSize, height: imageSize)
            
            if image.moderated == true {
                Rectangle()
                    .stroke(ColorList.light_blue.color, lineWidth: 1)
                    .background(ColorList.main_70.color)
                
                LottieView(name: "loading_heart")
                
                VStack {
                    Spacer()
                    
                    Text("photo_on_moderation".localized())
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 12))
                        .padding(.init(top: 0, leading: 8, bottom: 8, trailing: 8))
                }
            }
        }.frame(width: imageSize, height: imageSize, alignment: .bottom)
    }
}
