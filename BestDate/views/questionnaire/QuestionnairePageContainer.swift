//
//  QuestioonairePageContainer.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct QuestionnairePageContainer: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = QuestionnaireMediator.shared
    private var height: CGFloat = UIScreen.main.bounds.height - 170

    var body: some View {
        ZStack {
            SelectPageView(page: mediator.getPageByNumber(number: 6), total: mediator.total, state: mediator.dataPageStates,
                           previousAction: { mediator.toPreviousPage(
                            currentPage: mediator.dataPageStates,
                            previousPage: mediator.aboutPageStates,
                            backPage: nil) },
                           nextAction: { saveQuestionnaire() })

            let page = mediator.getPageByNumber(number: 5)
            InputPageView(page: page, questionInfo: page.questions[0], total: mediator.total, state: mediator.aboutPageStates,
                           previousAction: { mediator.toPreviousPage(
                            currentPage: mediator.aboutPageStates,
                            previousPage: mediator.freeTimePageStates,
                            backPage: mediator.dataPageStates) },
                           nextAction: { mediator.toNextPage(
                            topPage: mediator.aboutPageStates,
                            bottomPage: mediator.dataPageStates,
                            pageInBack: nil) })

            SelectPageView(page: mediator.getPageByNumber(number: 4), total: mediator.total, state: mediator.freeTimePageStates,
                           previousAction: { mediator.toPreviousPage(
                            currentPage: mediator.freeTimePageStates,
                            previousPage: mediator.searchPageStates,
                            backPage: mediator.aboutPageStates) },
                           nextAction: { mediator.toNextPage(
                            topPage: mediator.freeTimePageStates,
                            bottomPage: mediator.aboutPageStates,
                            pageInBack: mediator.dataPageStates) })

            SelectPageView(page: mediator.getPageByNumber(number: 3), total: mediator.total, state: mediator.searchPageStates,
                           previousAction: { mediator.toPreviousPage(
                            currentPage: mediator.searchPageStates,
                            previousPage: mediator.apperancePageStates,
                            backPage: mediator.freeTimePageStates) },
                           nextAction: { mediator.toNextPage(
                            topPage: mediator.searchPageStates,
                            bottomPage: mediator.freeTimePageStates,
                            pageInBack: mediator.aboutPageStates) })

            SelectPageView(page: mediator.getPageByNumber(number: 2), total: mediator.total, state: mediator.apperancePageStates,
                           previousAction: { mediator.toPreviousPage(
                            currentPage: mediator.apperancePageStates,
                            previousPage: mediator.personalPageStates,
                            backPage: mediator.searchPageStates) },
                           nextAction: { mediator.toNextPage(
                            topPage: mediator.apperancePageStates,
                            bottomPage: mediator.searchPageStates,
                            pageInBack: mediator.freeTimePageStates) })

            SelectPageView(page: mediator.getPageByNumber(number: 1), total: mediator.total, state: mediator.personalPageStates,
                           previousAction: { },
                           nextAction: { mediator.toNextPage(
                            topPage: mediator.personalPageStates,
                            bottomPage: mediator.apperancePageStates,
                            pageInBack: mediator.searchPageStates) })

        }.frame(height: height)
    }

    private func saveQuestionnaire() {
        mediator.getQuestionnaire()
        if mediator.isChanged() {
            mediator.saveProcess.toggle()
            mediator.saveQuestionnaire(questionnaire: mediator.userQuestinnaire) { success, message in
                DispatchQueue.main.async {
                    mediator.saveProcess.toggle()
                    if success {
                        store.dispatch(action: .navigate(screen: .MAIN))
                    } else {
                        store.dispatch(action: .show(message: message))
                    }
                }
            }
        } else {
            store.dispatch(action: .navigate(screen: .MAIN))
        }
    }
}
