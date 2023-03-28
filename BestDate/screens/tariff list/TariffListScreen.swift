//
//  TariffListScreen.swift
//  BestDate
//
//  Created by Евгений on 04.03.2023.
//

import SwiftUI

struct TariffListScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = TariffListMediator.shared

    var body: some View {
        ZStack {
            VStack {
                Image("ic_splash_decor")

                Spacer()
            }.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Spacer()

                    Button(action: {
                        UserDataHolder.setStartScreen(screen: .MAIN)
                        withAnimation { store.dispatch(action: .navigationBack) }
                    }) {
                        Text("cancel".localized())
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                    }.padding(16)
                }.padding(.init(top: 20, leading: 32, bottom: 0, trailing: 32))

                TariffSliderView()

                Spacer()
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }
}

struct TariffListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TariffListScreen()
    }
}
