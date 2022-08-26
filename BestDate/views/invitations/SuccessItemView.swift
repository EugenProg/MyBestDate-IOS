//
//  SuccessItem.swift
//  BestDate
//
//  Created by Евгений on 26.08.2022.
//

import SwiftUI

struct SuccessItemView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(ColorList.chat_blue.color)

            Image("ic_check_white")
        }.frame(width: 22, height: 22)
    }
}
