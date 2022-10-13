//
//  ConfirmationView.swift
//  BestDate
//
//  Created by Евгений on 04.07.2022.
//

import SwiftUI

struct ConfirmationView: View {

    @Binding var isSelect: Bool

    var body: some View {
        HStack(spacing: 2) {
            if isSelect {
                Image("ic_verify_active")

//                Text("confirmed")
//                    .foregroundColor(ColorList.pink.color)
//                    .font(MyFont.getFont(.BOLD, 12))
            } else {
                Image("ic_verify_unactive")
            }
        }
    }
}
