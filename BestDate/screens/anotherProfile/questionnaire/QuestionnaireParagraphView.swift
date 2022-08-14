//
//  QuestionnaireParagraph.swift
//  BestDate
//
//  Created by Евгений on 26.07.2022.
//

import SwiftUI

struct QuestionnaireParagraphView: View {
    var paragraph: QuestionnaireParagraph?

    fileprivate func pointView(item: QuestionnairePoint) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(item.title)
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 20))

            Text(item.value ?? "-")
                .foregroundColor(ColorList.white_40.color)
                .font(MyFont.getFont(.NORMAL, 20))
                .padding(.init(top: 10, leading: 0, bottom: 15, trailing: 0))

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(width: UIScreen.main.bounds.width - 64, height: 1)
        }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            .frame(width: UIScreen.main.bounds.width - 64)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(paragraph?.title ?? "")
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 22))
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))

                ForEach(paragraph?.points ?? [], id: \.id) { point in
                    pointView(item: point)
                }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.init(top: 30, leading: 32, bottom: 5, trailing: 32))
    }
}

