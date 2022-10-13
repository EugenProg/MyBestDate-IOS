//
//  SearchInputView.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import SwiftUI

struct SearchInputView: View {

    var hint: String
    var light: Bool = true
    @Binding var input: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(light ? ColorList.main_5.color : ColorList.white_5.color)

            VStack(alignment: .leading, spacing: 5) {
                Text(NSLocalizedString(hint, comment: "Question"))
                    .foregroundColor(light ? ColorList.main_60.color : ColorList.white_60.color)
                    .font(MyFont.getFont(.NORMAL, 12))

                TextField("", text: $input)
                    .foregroundColor(light ? ColorList.main.color : ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 20))

            }
                .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 22))
        }.frame(width: UIScreen.main.bounds.width - 36, height: 76)
            .padding(.init(top: 1, leading: 18, bottom: 1, trailing: 18))

    }
}

