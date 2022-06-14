//
//  BluredImageHeaderView.swift
//  BestDate
//
//  Created by Евгений on 15.06.2022.
//

import SwiftUI

struct BluredImageHeaderView: View {
    
    @Binding var image: UIImage
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient:
                                            Gradient(colors: [
                                                MyColor.getColor(40, 48, 52, 0.62),
                                                MyColor.getColor(40, 48, 52, 0.17),
                                                MyColor.getColor(40, 48, 52, 0.0)
                                            ]), startPoint: .top, endPoint: .bottom))
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .background(
                    Image(uiImage: image)
                        .resizable()
                        .blur(radius: 50)
                        .edgesIgnoringSafeArea(.all))
            Spacer()
            
        }.frame(height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)
    }
}
