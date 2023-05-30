//
//  TariffListScreen.swift
//  BestDate
//
//  Created by Евгений on 04.03.2023.
//

import SwiftUI
import StoreKit

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
                        UserDataHolder.shared.setStartScreen(screen: .MAIN)
                        withAnimation { store.dispatch(action: .navigationBack) }
                    }) {
                        Text("cancel".localized())
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                    }.padding(16)
                }.padding(.init(top: 20, leading: 32, bottom: 16, trailing: 32))

                TariffSliderView(tariffList: $mediator.tariffsList) { product in
                    subscribe(product: product)
                }
                    .frame(height: 550)

                Spacer()
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
        .task {
            Task {
                do {
                    try await SubscriptionManager.shared.loadProducts()
                    mediator.initTariffList()
                } catch {
                    print(error)
                }
            }
        }
    }

    private func subscribe(product: Product) {
        Task {
            do {
                try await SubscriptionManager.shared.purchase(product)
            } catch {
                print(error)
            }
        }
    }
}

struct TariffListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TariffListScreen()
    }
}
