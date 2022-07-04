//
//  PageButtonsView.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct PageButtonsView: View {
    @ObservedObject var mediator = QuestionnaireMediator.shared
    var page: QuestionnairePage

    var previousAction: () -> Void
    var nextAction: () -> Void

    @State var process: Bool = false
    var animation = Animation.easeInOut(duration: 0.7)

    var body: some View {
        HStack {
            Button(action: {
                withAnimation(animation) { previousAction() }
            }) {
                Text("back")
                    .foregroundColor(page.number > 1 ? ColorList.main.color : ColorList.main_10.color)
                    .font(MyFont.getFont(.BOLD, 18))
                    .padding(.init(top: 18, leading: 40, bottom: 18, trailing: 40))
            }.frame(width: (UIScreen.main.bounds.width - 114) / 2)
                .padding(.init(top: 0, leading: 14, bottom: 0, trailing: 0))

            Spacer()

            StandardButton(style: .blue, title: page.buttonTitle, loadingProcess: $process) {
                withAnimation(animation) { nextAction() }
            }.frame(width: UIScreen.main.bounds.width / 2)
        }
    }
}
