//
//  PercentView.swift
//  BestDate
//
//  Created by Евгений on 28.06.2022.
//

import SwiftUI

struct PercentView: View {

    @Binding var questionInfo: QuestionInfo
    var isAlwaisActive: Bool = false

    var unActiveColor = ColorList.main_20.color
    var activeBlueColor = ColorList.blue.color
    
    var body: some View {
        HStack(spacing: 5) {
            let isUnActive = questionInfo.selectedAnsfer.isEmpty

            Text("+")
                .foregroundColor(isUnActive && !isAlwaisActive ? unActiveColor : activeBlueColor)
                .font(MyFont.getFont(.BOLD, 16))

            Text("\(questionInfo.percent)")
                .foregroundColor(isUnActive && !isAlwaisActive ? unActiveColor : activeBlueColor)
                .font(MyFont.getFont(.BOLD, 26))

            Text("%")
                .foregroundColor(isUnActive && !isAlwaisActive ? unActiveColor : activeBlueColor)
                .font(MyFont.getFont(.BOLD, 16))
        }
    }
}
