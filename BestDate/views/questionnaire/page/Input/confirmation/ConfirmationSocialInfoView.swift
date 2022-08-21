//
//  ConfirmationSocialInfoView.swift
//  BestDate
//
//  Created by Евгений on 18.08.2022.
//

import SwiftUI

struct ConfirmationSocialInfoView: View {
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
                VStack(alignment: .leading, spacing: 1) {
                    Text(NSLocalizedString(questionInfo.question, comment: "Question"))
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 20))

                    if mediator.socialNetworkes.isEmpty {
                        Text(NSLocalizedString(questionInfo.ansfers.first ?? "", comment: "Answer"))
                            .foregroundColor(ColorList.main_60.color)
                            .font(MyFont.getFont(.NORMAL, 12))
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(mediator.socialNetworkes.indices, id: \.self) { index in
                                    Image(mediator.socialNetworkes[index].type.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 15)
                                }
                            }
                        }.padding(.init(top: 3, leading: 0, bottom: 0, trailing: 0))
                    }
                }

                Spacer()
            }
            .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 22))
        }.frame(width: UIScreen.main.bounds.width - 64, height: 76)
            .padding(.init(top: 1, leading: 14, bottom: 1, trailing: 14))
            .onAppear{
                mediator.setQuestionInfo(questionInfo: questionInfo)
                isConfirmed = !questionInfo.selectedAnsfer.isEmpty
                questionInfo.selectAction = { ansfer in
                    isConfirmed = !ansfer.isEmpty
                    QuestionnaireMediator.shared.saveSelection(questionInfo: questionInfo, ansfer: ansfer)
                    questionInfo.selectedAnsfer = ansfer
                }
            }
            .onTapGesture {
                mediator.setQuestionInfo(questionInfo: questionInfo)
                store.dispatch(action: .showBottomSheet(view: .QUESTIONNAIRE_VERIFICATION))
            }
    }
}
