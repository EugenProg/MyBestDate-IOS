//
//  TariffItemView.swift
//  BestDate
//
//  Created by Евгений on 04.03.2023.
//

import SwiftUI

struct TariffItemView: View {

    var tariff: TariffType
    @State var buttonLoading: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text(tariff.title.localized().uppercased())
                    .foregroundColor(tariff.color)
                    .font(MyFont.getFont(.BOLD, 20))

                Spacer()

                if tariff.popular {
                    Text("popular")
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 12))
                        .padding(.init(top: 5, leading: 18, bottom: 5, trailing: 18))
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(ColorList.light_blue.color)
                        )
                }
            }.padding(.init(top: 37, leading: 26, bottom: 32, trailing: 26))

            Image("bg_tariff_logo")

            Text("€ \(String(format: "%.2f", tariff.amount))")
                .foregroundColor(.white)
                .font(MyFont.getFont(.BOLD, 60))

            Text(tariff.period.localized())
                .foregroundColor(ColorList.white_40.color)
                .font(MyFont.getFont(.NORMAL, 16))

            StandardButton(style: tariff.buttonStyle, title: "get_started", loadingProcess: $buttonLoading) {

            }.padding(.init(top: 30, leading: 8, bottom: 16, trailing: 8))

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(height: 1)
                .padding(.init(top: 0, leading: 26, bottom: 16, trailing: 26))

            HStack {
                Text("features".localized().uppercased())
                    .foregroundColor(ColorList.white_80.color)
                    .font(MyFont.getFont(.BOLD, 16))

                Spacer()
            }.padding(.leading, 26)

            HStack {
                Text("everything_in_this_plan".localized())
                    .foregroundColor(ColorList.white_40.color)
                    .font(MyFont.getFont(.NORMAL, 16))

                Spacer()
            }.padding(.leading, 26)
                .padding(.bottom, 16)


            itemPoints(imageName: "ic_settings_invitations", text: "unlimited_invite_cards", switchName: tariff.switchImage)
                .padding(.bottom, 16)

            itemPoints(imageName: "ic_settings_message", text: "unlimited_messages", switchName: tariff.switchImage)
                .padding(.bottom, 32)

        }.frame(width: UIScreen.main.bounds.width - 105)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(MyColor.getColor(255, 255, 255, 0.1), lineWidth: 1)
                    .background(
                        LinearGradient(colors: [
                            MyColor.getColor(45, 54, 59),
                            MyColor.getColor(46, 50, 67)
                        ], startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(28)
                    .shadow(color: MyColor.getColor(0, 0, 0, 0.1), radius: 16, y: 8)
            )
    }

    fileprivate func itemPoints(imageName: String, text: String, switchName: String) -> some View {
        HStack(spacing: 0) {
            Image(imageName)

            VStack(alignment: .leading, spacing: 0) {
                Text(text.localized())
                    .foregroundColor(ColorList.white_80.color)
                    .font(MyFont.getFont(.BOLD, 16))

                Text("active".localized())
                    .foregroundColor(ColorList.light_blue.color)
                    .font(MyFont.getFont(.NORMAL, 16))
            }.padding(.leading, 12)

            Spacer(minLength: 0)

            ZStack {
                Image(switchName)

                Image("ic_check_black")
            }
        }.padding(.init(top: 0, leading: 23, bottom: 0, trailing: 23))
    }
}
