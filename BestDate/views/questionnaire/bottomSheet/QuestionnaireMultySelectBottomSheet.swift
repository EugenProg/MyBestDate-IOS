//
//  QuestionnaireMultySelectBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import SwiftUI

struct QuestionnaireMultySelectBottomSheet: View {
    @ObservedObject var mediator = MultySelectMediator.shared
    @ObservedObject var baseMediator = BaseButtonSheetMediator.shared
    @ObservedObject var questionnaireMediator = QuestionnaireMediator.shared

    var clickAction: () -> Void
    
    var body: some View {
        let headerHeigh = mediator.questionInfo.question.count > 20 ? 70 : 35
        let itemsHeight: CGFloat = CGFloat(mediator.questionInfo.ansfers.count * 61 + headerHeigh)
        let viewHeight: CGFloat = UIScreen.main.bounds.height - 100
        let height: CGFloat = itemsHeight > viewHeight ? viewHeight : itemsHeight

        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Title(textColor: ColorList.main.color, text: mediator.questionInfo.question, textSize: 32, paddingV: 0, paddingH: 24)

                Spacer()

                PercentView(questionInfo: $mediator.questionInfo, isAlwaisActive: true)
            }.padding(.init(top: 0, leading: 0, bottom: 18, trailing: 24))

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(mediator.ansfersList, id: \.id) { ansferInfo in
                        AnsferItemView(ansfer: ansferInfo.ansfer, isSelect: ansferInfo.isSelect) { _ in

                            mediator.toggleItemSelect(id: ansferInfo.id)
                        }
                    }
                }
            }

        }.frame(width: UIScreen.main.bounds.width, height: height, alignment: .topLeading)
            .onAppear {
                baseMediator.closeAction = { type in
                    if type == .QUESTIONNAIRE_MULTY_SELECT {
                        let ansferLine = mediator.getAnsferLine()
                        calculateProgress(ansferLine: ansferLine)
                        questionnaireMediator.saveSelection(questionInfo: mediator.questionInfo, ansfer: ansferLine)
                        mediator.questionInfo.selectAction!(mediator.getAnsferLine(true))
                    }
                }
            }
    }

    private func calculateProgress(ansferLine: String) {
        if mediator.questionInfo.selectedAnsfer.isEmpty && !ansferLine.isEmpty {
            questionnaireMediator.addProgress(progress: mediator.questionInfo.percent)
        } else if !mediator.questionInfo.selectedAnsfer.isEmpty && ansferLine.isEmpty {
            questionnaireMediator.removeProgress(progress: mediator.questionInfo.percent)
        }
    }
}
