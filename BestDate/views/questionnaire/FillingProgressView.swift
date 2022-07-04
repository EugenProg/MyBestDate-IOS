//
//  FillingProgressView.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct FillingProgressView: View {
    @ObservedObject var mediator = QuestionnaireMediator.shared

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(NSLocalizedString(mediator.title, comment: "comment"))
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 26))

                Spacer()

                Text("\(mediator.progress)")
                    .foregroundColor(ColorList.light_blue.color)
                    .font(MyFont.getFont(.BOLD, 26))

                Text("%")
                    .foregroundColor(ColorList.light_blue.color)
                    .font(MyFont.getFont(.BOLD, 16))
                    .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
            }

            ZStack {
                ProgressBarView(progress: $mediator.progress, backColor: ColorList.white_10.color, progressColor: ColorList.light_blue.color)

                SurprizeBoxView(checked: $mediator.firstSurprize)

                HStack {
                    Spacer()
                    SurprizeBoxView(checked: $mediator.finalSurprize)
                }.frame(width: UIScreen.main.bounds.width - 64)
            }.padding(.init(top: 4, leading: 0, bottom: 0, trailing: 0))

            HStack {
                Text("normally")
                    .foregroundColor(ColorList.white_60.color)
                    .font(MyFont.getFont(.NORMAL, 12))

                Spacer()

                Text("nice")
                    .foregroundColor(ColorList.white_60.color)
                    .font(MyFont.getFont(.NORMAL, 12))

                Spacer()

                Text("excellent")
                    .foregroundColor(ColorList.white_60.color)
                    .font(MyFont.getFont(.NORMAL, 12))
            }
        }.padding(.init(top: 3, leading: 32, bottom: 10, trailing: 32))
    }
}

struct FillingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        FillingProgressView()
    }
}
