//
//  QuestionnaireParagraph.swift
//  BestDate
//
//  Created by Евгений on 26.07.2022.
//

import SwiftUI

struct QuestionnaireParagraphView: View {
    var paragraph: QuestionnaireParagraph?
    var translateAction: ((String) -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(paragraph?.title ?? "")
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 22))
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))

                ForEach(paragraph?.points ?? [], id: \.id) { point in
                    if point.trnaslatableView {
                        TranslatableView(item: point) { text in
                            if translateAction != nil {
                                translateAction!(text)
                            }
                        }
                    } else {
                        PointView(item: point)
                    }
                }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.init(top: 30, leading: 32, bottom: 5, trailing: 32))
    }
}

struct PointView: View {
    var item: QuestionnairePoint

    var body: some View {
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
}

struct TranslatableView: View {
    var item: QuestionnairePoint
    var translateAction: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(item.title)
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 20))

            HStack {
                Text(item.value ?? "-")
                    .foregroundColor(ColorList.white_40.color)
                    .font(MyFont.getFont(.NORMAL, 20))

                Spacer()

                if item.translatable {
                    Button(action: {
                        translateAction(item.value ?? "")
                    }) {
                        Image("ic_translate")
                    }
                }
            }
            .padding(.init(top: 10, leading: 0, bottom: 15, trailing: 0))

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(width: UIScreen.main.bounds.width - 64, height: 1)
        }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            .frame(width: UIScreen.main.bounds.width - 64)
    }
}
