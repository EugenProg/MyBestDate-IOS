//
//  RangeSelectView.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import SwiftUI

struct RangeSelectView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = QuestionnaireMediator.shared

    @Binding var questionInfo: QuestionInfo

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(ColorList.main_5.color)

            VStack(alignment: .leading, spacing: 1) {
                Text(questionInfo.question.localized())
                    .foregroundColor(ColorList.main_60.color)
                    .font(MyFont.getFont(.NORMAL, 12))
                    .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))

                RangeBarView(start: getMin(), end: getMax(), startNumber: $mediator.startAgeRange, endNumber: $mediator.endAgeRange)
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
            }.frame(width: UIScreen.main.bounds.width - 110, alignment: .leading)
        }.frame(width: UIScreen.main.bounds.width - 64, height: 118)
            .padding(.init(top: 1, leading: 14, bottom: 1, trailing: 14))
    }

    private func getMin() -> CGFloat {
        if let str = NumberFormatter().number(from: questionInfo.ansfers[0]) {
            return CGFloat(truncating: str)
        }
        return 0
    }

    private func getMax() -> CGFloat {
        if let str = NumberFormatter().number(from: questionInfo.ansfers[1]) {
            return CGFloat(truncating: str)
        }
        return 100
    }
}
