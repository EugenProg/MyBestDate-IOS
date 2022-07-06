//
//  QuestionnaireSearchBotomSheet.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import SwiftUI

struct QuestionnaireSearchBotomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = SingleSelectMediator.shared
    @ObservedObject var searchMediator = CitySearchMediator.shared

    var clickAction: () -> Void

    @State var input: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                BackButton(style: .black) { clickAction() }

                Spacer()

                TextButton(text: "save", textColor: ColorList.main.color) {
                    mediator.questionInfo.selectAction!(NSLocalizedString(input, comment: "Ansfer") )
                    clickAction()
                }
            }.frame(width: UIScreen.main.bounds.width - 64)
                .padding(.init(top: 32, leading: 32, bottom: 25, trailing: 32))
            HStack {
                Title(textColor: ColorList.main.color, text: mediator.questionInfo.question, textSize: 32, paddingV: 0, paddingH: 32)

                Spacer()

                PercentView(questionInfo: $mediator.questionInfo, isAlwaisActive: true)
            }.padding(.init(top: 0, leading: 0, bottom: 18, trailing: 24))

            SearchInputView(hint: "specify_the_search_location", input: $input)
                .padding(.init(top: 0, leading: 0, bottom: 13, trailing: 0))

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(searchMediator.cityList, id: \.self) { city in
                        Text(city)
                            .foregroundColor(ColorList.main_90.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .frame(width: UIScreen.main.bounds.width - 64, height: 48, alignment: .leading)
                            .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))
                            .onTapGesture {
                                input = city
                            }
                    }
                }
            }

            HStack(spacing: 4) {
                Text("powered by")
                    .foregroundColor(ColorList.main_60.color)
                    .font(MyFont.getFont(.NORMAL, 16))
                Text("Google")
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 18))
            }.frame(width: UIScreen.main.bounds.width)
                .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 16, trailing: 0))

        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            .onAppear {
                input = mediator.questionInfo.selectedAnsfer
            }
    }
}
