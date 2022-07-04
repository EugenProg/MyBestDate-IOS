//
//  ProgressBarView.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: Int
    var height: CGFloat = 8
    var backColor: Color
    var progressColor: Color

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(backColor)
                .frame(width: UIScreen.main.bounds.width - 64, height: height)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(progressColor)
                .frame(width: ((UIScreen.main.bounds.width - 64) / 100) * CGFloat(progress), height: height, alignment: .leading)
        }
    }
}

