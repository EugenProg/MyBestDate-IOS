//
//  LanguageBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 15.09.2022.
//

import SwiftUI

struct LanguageBottomSheet: View {
    @ObservedObject var mediator = LanguageMediator.shared

    var clickAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "language", textSize: 28, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 14, trailing: 0))

            ForEach(mediator.itemList, id: \.id) { item in
                DarkBottomSheetItem(text: item.type.name, isSelect: equals(item: item.type.name)) { name in
                    mediator.saveLanguage(language: item.type)
                    clickAction()
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }

    private func equals(item: String) -> Bool {
        item.lowercased() == "app_lang".localized()
    }
}
