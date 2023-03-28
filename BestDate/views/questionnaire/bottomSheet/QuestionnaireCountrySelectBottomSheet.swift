//
//  QuestionnaireCountrySelectBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 24.03.2023.
//

import SwiftUI

struct QuestionnaireCountrySelectBottomSheet: View {
    @ObservedObject var mediator = SingleSelectMediator.shared
    @ObservedObject var questionnaireMediator = QuestionnaireMediator.shared

    var clickAction: () -> Void

    var body: some View {
        let headerHeigh = mediator.questionInfo.question.count > 20 ? 70 : 35
        let itemsHeight: CGFloat = CGFloat(mediator.questionInfo.ansfers.count * 61 + headerHeigh)
        let viewHeight: CGFloat = UIScreen.main.bounds.height - 60
        let height: CGFloat = itemsHeight > viewHeight ? viewHeight : itemsHeight

        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Title(textColor: ColorList.main.color, text: mediator.questionInfo.question, textSize: 32, paddingV: 0, paddingH: 24)

                Spacer()

                TextButton(text: "cancel", textColor: ColorList.main.color) {
                    clickAction()
                }
            }.padding(.init(top: 0, leading: 0, bottom: 18, trailing: 24))

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(mediator.questionInfo.ansfers, id: \.self) { ansfer in
                        AnsferItemView(ansfer: ansfer, isSelect: equals(ansfer: ansfer)) { selectedAnsfer in

                            calculateProgress()

                            mediator.questionInfo.selectAction!(ansfer)
                            questionnaireMediator.saveSelection(questionInfo: mediator.questionInfo, ansfer: ansfer)

                            clickAction()
                        }
                    }
                }
            }

        }.frame(width: UIScreen.main.bounds.width, height: height, alignment: .topLeading)
    }

    private func equals(ansfer: String) -> Bool {
        ansfer == mediator.questionInfo.selectedAnsfer ||
        ansfer.localized() == mediator.questionInfo.selectedAnsfer
    }

    private func calculateProgress() {
        if mediator.questionInfo.selectedAnsfer.isEmpty {
            questionnaireMediator.addProgress(progress: mediator.questionInfo.percent)
        }
    }
}
