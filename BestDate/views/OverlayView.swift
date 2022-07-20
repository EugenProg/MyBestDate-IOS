//
//  OverlayView.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct OverlayView: View {
    var reverse: Bool = false

    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient:
                                    Gradient(colors: [
                                        MyColor.getColor(40, 48, 52, 0.62),
                                        MyColor.getColor(40, 48, 52, 0.17),
                                        MyColor.getColor(40, 48, 52, 0.0)
                                    ]), startPoint: reverse ? .bottom : .top, endPoint: reverse ? .top : .bottom))
    }
}
