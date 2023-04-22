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
                            mediator.clearData()
                            store.dispatch(action: .navigationBack)
                        }

                        Spacer()
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
                    QuestionnaireParagraphView(paragraph: mediator.generalInfo) { text in
                        mediator.translate(text: text)
                    }

                    QuestionnaireParagraphView(paragraph: mediator.personalInfo)

                    QuestionnaireParagraphView(paragraph: mediator.freeTime)

                    if !mediator.socialNetworks.isEmpty {
                        HStack(spacing: 16) {
                            ForEach(mediator.socialNetworks.indices, id: \.self) { index in
                                let net = mediator.socialNetworks[index]
                                Button(action: {
                                    store.dispatch(action: .openLink(link: net.link))
                                }) {
                                    Image(net.type.image)
                                        .renderingMode(.template)
                                        .foregroundColor(ColorList.white.color)
                                }
                            }
                        }.padding(.init(top: 30, leading: 0, bottom: 32, trailing: 0))
                    }
                }
            }.padding(.init(top: 94, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }.background(
            Image("bg_chat_decor")
                .resizable()
        ).edgesIgnoringSafeArea(.bottom)
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
