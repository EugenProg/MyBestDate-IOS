//
//  BuySubscriptionBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 07.05.2023.
//

import SwiftUI

struct BuySubscriptionBottomSheet: View {
    @EnvironmentObject var store: Store

    var clickAction: () -> Void
    @State var loading: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("you_want_see_who_viewed_your_profile".localized())
                .font(MyFont.getFont(.BOLD, 20))
                .foregroundColor(ColorList.white.color)
                .padding(.leading, 18)

            StandardButton(style: .white, title: "buy_a_subscription", loadingProcess: $loading) {
                clickAction()
                store.dispatch(action: .navigate(screen: .TARIFF_LIST))
            }.padding(.init(top: 57, leading: 0, bottom: 32, trailing: 0))
        }
    }
}
