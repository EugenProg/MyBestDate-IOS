//
//  QuestionnaireSingleSelectBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 28.06.2022.
//

import SwiftUI

struct QuestionnaireSingleSelectBottomSheet: View {
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

                PercentView(questionInfo: $mediator.questionInfo, isAlwaisActive: true)
            }.padding(.init(top: 0, leading: 0, bottom: 18, trailing: 24))

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(mediator.questionInfo.ansfers, id: \.self) { ansfer in
                        AnsferItemView(ansfer: ansfer, isSelect: equals(ansfer: ansfer)) { selectedAnsfer in

                            calculateProgress()

                            let selectedAnsfer = NSLocalizedString(selectedAnsfer, comment: "Ansfer")
                            mediator.questionInfo.selectAction!(selectedAnsfer)
                            questionnaireMediator.saveSelection(questionInfo: mediator.questionInfo, ansfer: selectedAnsfer)

                            clickAction()
                        }
                    }
                }
            }

        }.frame(width: UIScreen.main.bounds.width, height: height, alignment: .topLeading)
    }

    private func equals(ansfer: String) -> Bool {
        NSLocalizedString(ansfer, comment: "Ansfer").lowercased() == mediator.questionInfo.selectedAnsfer.lowercased()
    }

    private func calculateProgress() {
        if mediator.questionInfo.selectedAnsfer.isEmpty {
            questionnaireMediator.addProgress(progress: mediator.questionInfo.percent)
        }
    }
}
