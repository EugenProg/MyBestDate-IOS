//
//  LoadingProgressScreen.swift
//  BestDate
//
//  Created by Евгений on 03.09.2022.
//

import SwiftUI

struct LoadingProgressScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ProgressView()
                    .tint(ColorList.white.color)
                    .frame(width: 150, height: 150)
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
                .onTapGesture { }
        }
    }
}
