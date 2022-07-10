//
//  InputPageView.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct InputPageView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var questionnaireMediator = QuestionnaireMediator.shared

    @State var page: QuestionnairePage
    @State var questionInfo: QuestionInfo
    var total: Int
    @ObservedObject var state: PageStates
    @State var text: String = ""

    var previousAction: () -> Void
    var nextAction: () -> Void

    init(page: QuestionnairePage, questionInfo: QuestionInfo, total: Int, state: PageStates, previousAction: @escaping () -> Void, nextAction: @escaping () -> Void) {
            UITextView.appearance().backgroundColor = .clear
        self.page = page
        self.questionInfo = questionInfo
        self.total = total
        self.state = state
        self.previousAction = previousAction
        self.nextAction = nextAction
        }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(ColorList.white.color)

            VStack(alignment: .leading, spacing: 0) {
                PageHeaderView(title: page.title, currentNumber: page.number, totalNumber: total)

                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(ColorList.main_5.color)

                    if text.isEmpty {
                        VStack {
                            Text(NSLocalizedString("tell_us_about_yourself_what_you_find_interesting", comment: "About you"))
                                .foregroundColor(ColorList.main_30.color)
                                .font(MyFont.getFont(.BOLD, 20))
                                .lineSpacing(6)
                                .padding(.init(top: 18, leading: 12, bottom: 18, trailing: 18))

                            Spacer()
                        }
                    }
                    VStack {
                        TextEditor(text: $text)
                            .foregroundColor(ColorList.main.color)
                            .font(MyFont.getFont(.BOLD, 20))
                            .padding(.init(top: 10, leading: 18, bottom: 18, trailing: 18))

                        HStack {
                            Spacer()
                            PercentView(questionInfo: $questionInfo)
                        }
                        .padding(.init(top: 0, leading: 18, bottom: 18, trailing: 18))
                    }
                }.padding(.init(top: 15, leading: 14, bottom: 14, trailing: 14))


                PageButtonsView(page: page,
                                previousAction: {
                                    calculateProgress()
                                    questionInfo.selectedAnsfer = text
                    questionnaireMediator.saveSelection(questionInfo: questionInfo, ansfer: text)
                                    previousAction()
                                },
                                nextAction: {
                                    calculateProgress()
                                    questionInfo.selectedAnsfer = text
                    questionnaireMediator.saveSelection(questionInfo: questionInfo, ansfer: text)
                                    nextAction()
                                }
                    )
                    .padding(.init(top: 0, leading: 0, bottom: 21, trailing: 0))
                }.frame(width: UIScreen.main.bounds.width - 36, alignment: .leading)

        }.padding(.init(top: 10, leading: 18, bottom: store.state.statusBarHeight + 32, trailing: 18))
            .offset(x: state.offset.width, y: state.offset.height)
            .rotationEffect(state.angle)
            .scaleEffect(state.zoom)
            .opacity(state.opacity)
            .onAppear {
                text = questionInfo.selectedAnsfer
            }
    }

    private func calculateProgress() {
        if text.isEmpty && !questionInfo.selectedAnsfer.isEmpty {
            questionnaireMediator.removeProgress(progress: questionInfo.percent)
        } else if !text.isEmpty && questionInfo.selectedAnsfer.isEmpty {
            questionnaireMediator.addProgress(progress: questionInfo.percent)
        }
    }
}
