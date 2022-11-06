//
//  MultySelectView.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import SwiftUI

struct MultySelectView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = MultySelectMediator.shared

    @Binding var questionInfo: QuestionInfo

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(ColorList.main_5.color)

            HStack(spacing: 5) {
                let isUnActive = questionInfo.selectedAnsfer.isEmpty

                VStack(alignment: .leading, spacing: 5) {
                    Text(questionInfo.question.localized())
                        .foregroundColor(isUnActive ? ColorList.main_20.color : ColorList.main_60.color)
                        .font(isUnActive ? MyFont.getFont(.BOLD, 20) : MyFont.getFont(.NORMAL, 12))
                        .padding(.init(top: isUnActive ? 20 : 0, leading: 0, bottom: 0, trailing: 0))

                    Text(questionInfo.selectedAnsfer)
                        .foregroundColor(ColorList.main.color)
                        .font(isUnActive ? MyFont.getFont(.BOLD, 2) : MyFont.getFont(.BOLD, 20))
                }
                .padding(.init(top: isUnActive ? 8 : 20, leading: 0, bottom: isUnActive ? 8 : 18, trailing: 0))

                Spacer()

                PercentView(questionInfo: $questionInfo)
            }
            .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 22))
        }.frame(width: UIScreen.main.bounds.width - 64)
            .padding(.init(top: 1, leading: 14, bottom: 1, trailing: 14))
            .onTapGesture {
                mediator.setQuestionInfo(questionInfo: questionInfo)
                store.dispatch(action: .showBottomSheet(view: .QUESTIONNAIRE_MULTY_SELECT))
            }
            .onAppear {
                questionInfo.selectAction = { ansfer in
                    questionInfo.selectedAnsfer = ansfer
                }
            }
    }
}
