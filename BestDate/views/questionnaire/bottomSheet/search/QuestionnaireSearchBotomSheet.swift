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
    @ObservedObject var questionnaireMediator = QuestionnaireMediator.shared

    @State var selectedItem: CityListItem? = nil

    var clickAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                BackButton(style: .black) { clickAction() }

                Spacer()

                TextButton(text: "save", textColor: ColorList.main.color) {
                    let answerLine = selectedItem == nil ? selectedItem?.getCityLine() : searchMediator.searchText
                    questionnaireMediator.saveSelection(questionInfo: mediator.questionInfo, ansfer: answerLine ?? "")
                    mediator.questionInfo.selectAction!(answerLine ?? "")
                    clickAction()
                }
            }.frame(width: UIScreen.main.bounds.width - 64)
                .padding(.init(top: 32, leading: 32, bottom: 25, trailing: 32))
            HStack {
                Title(textColor: ColorList.main.color, text: mediator.questionInfo.question, textSize: 32, paddingV: 0, paddingH: 32)

                Spacer()

                PercentView(questionInfo: $mediator.questionInfo, isAlwaisActive: true)
            }.padding(.init(top: 0, leading: 0, bottom: 18, trailing: 24))

            SearchInputView(hint: "specify_the_search_location", input: $searchMediator.searchText)
                .padding(.init(top: 0, leading: 0, bottom: 13, trailing: 0))

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(searchMediator.cityList, id: \.id) { item in
                        Text(item.getCityLine())
                            .foregroundColor(ColorList.main_90.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .frame(width: UIScreen.main.bounds.width - 64, height: 48, alignment: .leading)
                            .onTapGesture {
                                self.selectedItem = item
                                searchMediator.searchText = item.getCityLine()
                            }
                    }
                }
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

            HStack(spacing: 4) {
                Text("powered by")
                    .foregroundColor(ColorList.main_60.color)
                    .font(MyFont.getFont(.NORMAL, 16))
                Text("Google")
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 18))
            }.frame(width: UIScreen.main.bounds.width)
                .padding(.init(top: 0, leading: 0, bottom: 16, trailing: 0))

        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            .onTapGesture {
                store.dispatch(action: .hideKeyboard)
            }
            .onAppear {
                searchMediator.initSearch()
                let items = mediator.questionInfo.selectedAnsfer.components(separatedBy: ", ")
                selectedItem = CityListItem(id: 0, country: items.first, city: items.last ?? "")
                searchMediator.searchText = selectedItem?.getCityLine() ?? ""
            }
    }
}
