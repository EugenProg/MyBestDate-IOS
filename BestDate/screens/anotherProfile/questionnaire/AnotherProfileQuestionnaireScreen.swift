//
//  AnotherProfileQuestionnaireScreen.swift
//  BestDate
//
//  Created by Евгений on 26.07.2022.
//

import SwiftUI

struct AnotherProfileQuestionnaireScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = AnotherProfileQuestionnaireMediator.shared

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        BackButton(style: .white) {
                            AnotherProfileMediator.shared.setUser(user: mediator.user)
                            store.dispatch(action: .navigationBack)
                        }

                        Spacer()

                        Image("ic_menu_dots")
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                    }.frame(width: UIScreen.main.bounds.width - 64)

                    Title(textColor: ColorList.white.color, text: "questionnaire", textSize: 20, paddingV: 0, paddingH: 0)
                }.frame(height: 60)
                    .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 32))

                Rectangle()
                    .fill(MyColor.getColor(190, 239, 255, 0.15))
                    .frame(height: 1)
            }.background(ColorList.main.color)

            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    QuestionnaireParagraphView(paragraph: mediator.generalInfo)

                    QuestionnaireParagraphView(paragraph: mediator.personalInfo)

                    QuestionnaireParagraphView(paragraph: mediator.freeTime)
                }
            }.padding(.init(top: 94, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }.background(Image("bg_chat_decor").edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }
}

struct AnotherProfileQuestionnaireScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnotherProfileQuestionnaireScreen()
    }
}
