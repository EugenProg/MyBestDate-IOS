//
//  BluredImageHeaderView.swift
//  BestDate
//
//  Created by Евгений on 15.06.2022.
//

import SwiftUI

struct BluredImageHeaderView: View {
    
    @Binding var image: ProfileImage?
    var enableBlur: Bool = true
    
    var body: some View {
        VStack {
            ZStack {
                OverlayView()
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .background(
                    UpdateWithThumbImageView(image: $image)
                        .blur(radius: enableBlur ? 50 : 0)
                        .edgesIgnoringSafeArea(.all))
            Spacer()
            
        }.frame(height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)
    }
}
