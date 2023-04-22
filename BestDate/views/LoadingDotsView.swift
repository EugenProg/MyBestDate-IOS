//
//  LoadingView.swift
//  BestDate
//
//  Created by Евгений on 22.04.2023.
//

import SwiftUI

struct LoadingDotsView: View {
    @State var scale: CGFloat = 2

    var body: some View {
        LottieView(name: "loading_dots", loopMode: .loop)
            .scaleEffect(scale)
            .frame(width: 120, height: 50)
    }
}

struct LoadingDotsView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
