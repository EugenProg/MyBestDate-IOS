//
//  TariffItemView.swift
//  BestDate
//
//  Created by Евгений on 04.03.2023.
//

import SwiftUI
import StoreKit

struct TariffItemView: View {
    @Binding var tariff: Tariff
    var width: CGFloat
    @State var buttonLoading: Bool = false

    var subscribe: (Product) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(tariff.type.title.localized().uppercased())
                    .foregroundColor(tariff.type.color)
                    .font(MyFont.getFont(.BOLD, 20))

                Spacer()

                if tariff.type.popular {
                    Text("popular")
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 12))
                        .padding(.init(top: 5, leading: 18, bottom: 5, trailing: 18))
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(ColorList.light_blue.color)
                        )
                }
            }.padding(.init(top: 37, leading: 26, bottom: 8, trailing: 26))

            Image("bg_tariff_logo")

            Text(tariff.product?.displayPrice ?? "")
                .foregroundColor(.white)
                .font(MyFont.getFont(.BOLD, 60))

            Text(tariff.type.period.localized())
                .foregroundColor(ColorList.white_40.color)
                .font(MyFont.getFont(.NORMAL, 16))

            StandardButton(style: tariff.type.buttonStyle, title: "get_started", loadingProcess: $buttonLoading) {
                if tariff.product != nil {
                    subscribe(tariff.product!)
                }
            }.padding(.init(top: 16, leading: 8, bottom: 16, trailing: 8))

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


            itemPoints(imageName: "ic_settings_invitations", text: "unlimited_invite_cards", switchName: tariff.type.switchImage)
                .padding(.bottom, 16)

            itemPoints(imageName: "ic_settings_message", text: "unlimited_messages", switchName: tariff.type.switchImage)
                .padding(.bottom, 32)

        }.frame(width: width, height: 550)
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
