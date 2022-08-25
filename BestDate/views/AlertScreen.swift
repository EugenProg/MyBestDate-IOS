//
//  AlertScreen.swift
//  BestDate
//
//  Created by Евгений on 24.08.2022.
//

import SwiftUI

struct AlertScreen: View {
    @EnvironmentObject var store: Store
    @State var visible = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    Text(store.state.notificationText)
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 18))
                        .multilineTextAlignment(.center)
                        .padding(16)
                }.background(ColorList.light_blue.color)
                    .cornerRadius(16)
                    .padding(.init(top: 8, leading: 32, bottom: 32, trailing: 32))
                    .offset(x: 0, y: visible ? 0 : 70)
                    .opacity(visible ? 1 : 0)
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        }.onTapGesture { }
            .onAppear {
                withAnimation { visible = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    store.state.showMessage = false
                }
            }
    }
}

