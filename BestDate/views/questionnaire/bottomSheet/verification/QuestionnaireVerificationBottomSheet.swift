//
//  QuestionnaireEmailVerificationBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 17.08.2022.
//

import SwiftUI
import CoreMedia

struct QuestionnaireVerificationBottomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = VerificationMediator.shared

    @State var offset: CGFloat = 0

    var clickAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                BackButton(style: .black) { clickAction() }

                Spacer()

                if mediator.questionInfo.viewType == .CONFIRMATION_SOCIAL {
                    TextButton(text: "save", textColor: ColorList.main.color) {
                        if mediator.isValid() {
                            let ansferLine = mediator.getAnsferLine()
                            mediator.setAnsfers(ansfers: ansferLine)
                            mediator.questionInfo.selectAction!(ansferLine)
                            clickAction()
                        }
                    }
                }
            }.frame(width: UIScreen.main.bounds.width - 64)
                .padding(.init(top: 32, leading: 32, bottom: 25, trailing: 32))
            HStack {
                Title(textColor: ColorList.main.color, text: mediator.questionInfo.question, textSize: 32, paddingV: 0, paddingH: 32)

                Spacer()
            }.padding(.init(top: 0, leading: 0, bottom: 18, trailing: 24))

            ScrollView(.vertical, showsIndicators: false) {
                getViewByType(type: mediator.questionInfo.viewType)
            }
            .keyboardSensible($offset)
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            .onTapGesture {
                store.dispatch(action: .hideKeyboard)
            }
    }

    private func getViewByType(type: QuestionViewType) -> some View {
        Group {
            switch type {
            case .CONFIRMATION_EMAIL: EmailVerficationView()
            case .CONFIRMATION_PHONE: PhoneVerificationView()
            case .CONFIRMATION_SOCIAL: SocialVerificationView()
            default: EmailVerficationView()
            }
        }
    }
}

