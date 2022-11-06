//
//  DateSelectView.swift
//  BestDate
//
//  Created by Евгений on 12.06.2022.
//

import SwiftUI

struct DateSelectView: View {
    var hint: String
    var imageName: String
    @Binding var date: Date
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(MyColor.getColor(231, 238, 242, 0.12)), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(24)
    
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(hint.localized())
                        .foregroundColor(ColorList.white_60.color)
                        .font(MyFont.getFont(.NORMAL, 12))
                    ZStack {
                        DatePicker("Birth date", selection: $date, in: ...Date.getEithteenYearsAgoDate(), displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(CompactDatePickerStyle())
                        .background(MyColor.getColor(0, 0, 0, 0))
                        .applyTextColor(ColorList.white.color)
                    }
                }
                Spacer()
                Image(imageName)
                    .renderingMode(.template)
                    .foregroundColor(ColorList.white.color)
                    
            }.padding(.init(top: 18, leading: 27, bottom: 16, trailing: 24))
        }
        .frame(height: 76)
        .padding(.init(top: 13, leading: 18, bottom: 12, trailing: 18))
    }
}
