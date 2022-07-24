//
//  DuelColorfullTitle.swift
//  BestDate
//
//  Created by Евгений on 21.07.2022.
//

import SwiftUI

struct DuelColorfullTitle: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("DU")
                .foregroundColor(ColorList.light_blue.color)
                .font(MyFont.getFont(.BOLD, 14))
            Text("EL")
                .foregroundColor(ColorList.pink.color)
                .font(MyFont.getFont(.BOLD, 14))
        }
    }
}

struct DuelColorfullTitle_Previews: PreviewProvider {
    static var previews: some View {
        DuelColorfullTitle()
    }
}
