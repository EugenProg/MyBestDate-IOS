//
//  QuestionnaireSeekBarBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 30.06.2022.
//

import SwiftUI

struct QuestionnaireSeekBarBottomSheet: View {
    @ObservedObject var mediator = SingleSelectMediator.shared
    @ObservedObject var baseMediator = BaseButtonSheetMediator.shared
    @ObservedObject var questionnaireMediator = QuestionnaireMediator.shared

    var clickAction: () -> Void
    @State var number: Int = 10

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Title(textColor: ColorList.main.color, text: mediator.questionInfo.question, textSize: 32, paddingV: 0, paddingH: 24)

                Spacer()

                PercentView(questionInfo: $mediator.questionInfo, isAlwaisActive: true)
            }.padding(.init(top: 0, leading: 0, bottom: 18, trailing: 24))

            ZStack {
                SeekBarView(start: getMin(), end: getMax(), number: $number)
            }.frame(height: 180)

            SecondStylesTextButton(firstText: "do_not_specify_height", secondText: "cancel", firstTextColor: ColorList.main_60.color, secondTextColor: ColorList.main.color) {
                clickAction()
            }.frame(width: UIScreen.main.bounds.width)

        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            .onAppear {
                number = Int(mediator.questionInfo.selectedAnsfer) ?? 80
                baseMediator.closeAction = { type in
                    if type == .QUESTIONNAIRE_SEEK_BAR {
                        calculateProgress()
                        mediator.questionInfo.selectAction!(String(number))
                    }
                }
            }
    }

    private func calculateProgress() {
        if mediator.questionInfo.selectedAnsfer.isEmpty {
            questionnaireMediator.addProgress(progress: mediator.questionInfo.percent)
        }
    }

    private func getMin() -> CGFloat {
        if let str = NumberFormatter().number(from: mediator.questionInfo.ansfers[0]) {
            return CGFloat(truncating: str)
        }
        return 0
    }

    private func getMax() -> CGFloat {
        if let str = NumberFormatter().number(from: mediator.questionInfo.ansfers[1]) {
            return CGFloat(truncating: str)
        }
        return 100
    }
}
