//
//  CloseItemView.swift
//  BestDate
//
//  Created by Евгений on 26.08.2022.
//

import SwiftUI

struct CloseItemView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(ColorList.main.color)

            Image("ic_close_white")
        }.frame(width: 22, height: 22)
    }
}

struct CloseItemView_Previews: PreviewProvider {
    static var previews: some View {
        CloseItemView()
    }
}
