//
//  NoDuelData.swift
//  BestDate
//
//  Created by Евгений on 28.07.2022.
//

import SwiftUI

struct NoDuelData: View {

    var size = UIScreen.main.bounds.width - 100

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(MyColor.getColor(255, 255, 255, 0.04), lineWidth: 1)
                .background(MyColor.getColor(34, 45, 51))
                .cornerRadius(16)
                .shadow(color: MyColor.getColor(12, 28, 33, 0.24), radius: 2, y: 3)

            Text("Sorry you voted for all the photos")
                .foregroundColor(ColorList.white.color)
                .multilineTextAlignment(.center)
                .font(MyFont.getFont(.BOLD, 22))
                .lineSpacing(5)
                .padding(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
        }.frame(width: size, height: 100)
    }
}

struct NoDuelData_Previews: PreviewProvider {
    static var previews: some View {
        NoDuelData()
    }
}
