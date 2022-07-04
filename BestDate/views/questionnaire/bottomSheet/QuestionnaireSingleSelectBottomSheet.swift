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
                        AnsferItemView(ansfer: ansfer, isSelect: NSLocalizedString(ansfer, comment: "Ansfer") == mediator.questionInfo.selectedAnsfer) { selectedAnsfer in

                            calculateProgress()

                            mediator.questionInfo.selectAction!(NSLocalizedString(selectedAnsfer, comment: "Ansfer") )

                            clickAction()
                        }
                    }
                }
            }

        }.frame(width: UIScreen.main.bounds.width, height: height, alignment: .topLeading)
    }

    private func calculateProgress() {
        if mediator.questionInfo.selectedAnsfer.isEmpty {
            questionnaireMediator.addProgress(progress: mediator.questionInfo.percent)
        }
    }
}
