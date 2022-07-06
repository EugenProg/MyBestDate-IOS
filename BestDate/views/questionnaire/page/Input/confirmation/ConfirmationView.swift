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
        HStack(spacing: 12) {
            if isSelect {
                Text("confirmed")
                    .foregroundColor(ColorList.pink.color)
                    .font(MyFont.getFont(.BOLD, 16))
                
                Image("ic_verify_active")
            } else {
                Image("ic_verify_unactive")
            }
        }
    }
}
