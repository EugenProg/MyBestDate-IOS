//
//  ConfirmationInfoView.swift
//  BestDate
//
//  Created by Евгений on 04.07.2022.
//

import SwiftUI

struct ConfirmationInfoView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = VerificationMediator.shared

    @Binding var questionInfo: QuestionInfo
    @State var isConfirmed: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(ColorList.main_5.color)

            HStack {
                Spacer()

                ConfirmationView(isSelect: $isConfirmed)
            }.padding(.init(top: 0, leading: 0, bottom: 0, trailing: 34))

            HStack(spacing: 5) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(questionInfo.question.localized())
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 20))
                    Text(getAnsfer())
                        .foregroundColor(ColorList.main_60.color)
                        .font(MyFont.getFont(.NORMAL, 12))
                }

                Spacer()
            }
            .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 22))
        }.frame(width: UIScreen.main.bounds.width - 64, height: 76)
            .padding(.init(top: 1, leading: 14, bottom: 1, trailing: 14))
            .onAppear{
                isConfirmed = !questionInfo.selectedAnsfer.isEmpty
                questionInfo.selectAction = { ansfer in
                    isConfirmed = !ansfer.isEmpty
                    questionInfo.selectedAnsfer = ansfer
                }
            }
            .onTapGesture {
                if questionInfo.viewType != .CONFIRMATION_SELECT {
                    mediator.questionInfo = questionInfo
                    store.dispatch(action: .showBottomSheet(view: .QUESTIONNAIRE_VERIFICATION))
                }
            }
    }

    private func getAnsfer() -> String {
        if questionInfo.selectedAnsfer.isEmpty {
            return (questionInfo.ansfers.first ?? "").localized()
        } else {
            return questionInfo.selectedAnsfer.localized()
        }
    }
}
