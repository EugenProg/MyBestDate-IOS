//
//  SelectPageView.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct SelectPageView: View {
    @EnvironmentObject var store: Store

    @State var page: QuestionnairePage
    var total: Int
    @ObservedObject var state: PageStates

    var previousAction: () -> Void
    var nextAction: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(ColorList.white.color)

            VStack(alignment: .leading, spacing: 0) {
                PageHeaderView(title: page.title, currentNumber: page.number, totalNumber: total)

                VStack(spacing: 0) {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(page.questions.indices, id: \.self) { index in
                            ZStack {
                                Group {
                                    switch page.questions[index].viewType {
                                        case .SINGLE_SELECT: SingleSelectInfoView(questionInfo: $page.questions[index])
                                        case .RANGE_SEEK_BAR: RangeSelectView(questionInfo: $page.questions[index])
                                        case .MULTY_SELECT: MultySelectView(questionInfo: $page.questions[index])
                                        case .CONFIRMATION_SELECT: ConfirmationInfoView(questionInfo: $page.questions[index])
                                    default: SingleSelectInfoView(questionInfo: $page.questions[index])
                                    }
                                }
                            }
                        }
                    }
                }.padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))

                PageButtonsView(page: page,
                                previousAction: { previousAction() },
                                nextAction: { nextAction() })
                    .padding(.init(top: 3, leading: 0, bottom: 21, trailing: 0))
                }.frame(width: UIScreen.main.bounds.width - 36, alignment: .leading)

        }.padding(.init(top: 10, leading: 18, bottom: store.state.statusBarHeight + 32, trailing: 18))
            .offset(x: state.offset.width, y: state.offset.height)
            .rotationEffect(state.angle)
            .scaleEffect(state.zoom)
            .opacity(state.opacity)
    }
}
