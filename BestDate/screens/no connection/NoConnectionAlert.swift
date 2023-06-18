//
//  NoConnectionAlert.swift
//  BestDate
//
//  Created by Евгений on 15.05.2023.
//

import SwiftUI

struct NoConnectionAlert: View {
    @State var visible = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .fill(ColorList.pink.color)
                            .blur(radius: 30)

                        Image("ic_no_connection")
                    }.frame(width: 44, height: 44)
                        .padding(.leading, 20)

                    VStack(alignment: .leading, spacing: 1) {
                        Text("weak_internet_connection".localized())
                            .font(MyFont.getFont(.BOLD, 18))
                            .foregroundColor(ColorList.white.color)

                        Text("check_your_internet".localized())
                            .font(MyFont.getFont(.NORMAL, 12))
                            .foregroundColor(ColorList.white_70.color)
                    }.padding(.leading, 15)

                    Spacer()
                }
                .frame(height: 108)
                .offset(x: 0, y: visible ? 0 : -200)
                .opacity(visible ? 1 : 0)
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(MyColor.getColor(255, 255, 255, 0.16), lineWidth: 1)
                        .background(ColorList.main.color)
                        .cornerRadius(32)
                        .shadow(color: MyColor.getColor(17, 24, 28, 0.7), radius: 46, y: 14)
                )
                .padding(.init(top: 32, leading: 18, bottom: 0, trailing: 18))

                Spacer()
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        .onTapGesture { }
            .onAppear {
                withAnimation { visible = true }
            }
    }
}

struct NoConnectionAlert_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionAlert()
    }
}
