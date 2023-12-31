//
//  SingleSelectInfoView.swift
//  BestDate
//
//  Created by Евгений on 28.06.2022.
//

import SwiftUI

struct SingleSelectInfoView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = SingleSelectMediator.shared

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

                    Text(getAnsfer())
                        .foregroundColor(ColorList.main.color)
                        .font(isUnActive ? MyFont.getFont(.BOLD, 2) : MyFont.getFont(.BOLD, 20))
                }

                Spacer()

                PercentView(questionInfo: $questionInfo)
            }
            .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 22))
        }.frame(width: UIScreen.main.bounds.width - 64, height: 76)
            .padding(.init(top: 1, leading: 14, bottom: 1, trailing: 14))
            .onTapGesture {
                mediator.questionInfo = questionInfo
                switch questionInfo.viewType {
                case .SINGLE_SELECT: store.dispatch(action: .showBottomSheet(view: .QUESTIONNAIRE_SINGLE_SELECT))
                case .COUNTRY_SELECT: store.dispatch(action: .showBottomSheet(view: .QUESTIONNAIRE_COUNTRY))
                case .SEEK_BAR_SELECT: store.dispatch(action: .showBottomSheet(view: .QUESTIONNAIRE_SEEK_BAR))
                case .SEARCH_SELECT: store.dispatch(action: .showBottomSheet(view: .QUESTIONNAIRE_SEARCH))
                default: store.dispatch(action: .showBottomSheet(view: .QUESTIONNAIRE_SINGLE_SELECT))
                }
            }
            .onAppear {
                questionInfo.selectAction = { ansfer in
                    questionInfo.selectedAnsfer = ansfer
                }
            }
    }

    private func getAnsfer() -> String {
        if !questionInfo.unitMask.isEmpty && questionInfo.selectedAnsfer.isEmpty {
            return ""
        }

        let ansfer = questionInfo.unitMask.isEmpty ? questionInfo.selectedAnsfer.localized() :
        String.localizedStringWithFormat(
            questionInfo.unitMask.localized(),
            questionInfo.selectedAnsfer.localized()
        )

        return ansfer
    }
}
