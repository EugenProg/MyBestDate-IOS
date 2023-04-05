//
//  LoadingNextPageView.swift
//  BestDate
//
//  Created by Евгений on 13.08.2022.
//

import SwiftUI

struct LoadingNextPageView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(MyColor.getColor(255, 255, 255, 0.04))
                .background(MyColor.getColor(41, 50, 54))

            ProgressView()
                .tint(ColorList.white.color)
                .scaleEffect(1.2)
        }.frame(width: UIScreen.main.bounds.width - 12, height: 84)
    }
}

struct LoadingNextPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingNextPageView()
    }
}
