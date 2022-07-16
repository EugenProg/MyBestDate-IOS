//
//  QuestionnaireScreen.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct QuestionnaireScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = QuestionnaireMediator.shared

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("ic_decor_elipse")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 308)
            }

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    BackButton(style: .white)

                    Spacer()

                    TextButton(text: "skip", textColor: ColorList.white.color) {
                        UserDataHolder.setStartScreen(screen: .MAIN)
                        store.dispatch(action: .navigate(screen: .MAIN))
                    }
                }.padding(.init(top: 32, leading: 32, bottom: 15, trailing: 32))

                FillingProgressView()

                QuestionnairePageContainer() {
                    saveQuestionnaire()
                }
            }

        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
            }
    }

    private func saveQuestionnaire() {
        mediator.getQuestionnaire()
        if mediator.isChanged() {
            mediator.saveProcess.toggle()
            mediator.saveQuestionnaire(questionnaire: mediator.userQuestinnaire) { success, message in
                DispatchQueue.main.async {
                    mediator.saveProcess.toggle()
                    if success {
                        UserDataHolder.setStartScreen(screen: .MAIN)
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
