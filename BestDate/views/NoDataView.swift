//
//  NoDataView.swift
//  BestDate
//
//  Created by Евгений on 20.07.2022.
//

import SwiftUI

struct NoDataView: View {
    @Binding var loadingMode: Bool

    var body: some View {
        if loadingMode {
            ProgressView()
                .tint(ColorList.white.color)
                .frame(width: 80, height: 80)
        } else {
            LottieView(name: "no_data")
                .frame(width: 150, height: 150)
        }
    }
}

