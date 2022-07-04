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
                    BackButton(style: .white) {
                        mediator.removeProgress(progress: 10)
                    }

                    Spacer()

                    TextButton(text: "skip", textColor: ColorList.white.color) {
                        mediator.addProgress(progress: 10)
                    }
                }.padding(.init(top: 32, leading: 32, bottom: 15, trailing: 32))

                FillingProgressView()

                QuestionnairePageContainer()
            }

        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
            }
    }
}

struct QuestionnaireScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireScreen()
    }
}
