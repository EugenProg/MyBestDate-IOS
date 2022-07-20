//
//  ConfirmationInfoView.swift
//  BestDate
//
//  Created by Евгений on 04.07.2022.
//

import SwiftUI

struct ConfirmationInfoView: View {

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
                    Text(NSLocalizedString(questionInfo.question, comment: "Question"))
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
            }
    }

    private func getAnsfer() -> String {
        if questionInfo.selectedAnsfer.isEmpty {
            return NSLocalizedString(questionInfo.ansfers.first ?? "123", comment: "Answer")
        } else {
            return NSLocalizedString(questionInfo.selectedAnsfer, comment: "Answer")
        }
    }
}