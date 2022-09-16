//
//  BlackListScreen.swift
//  BestDate
//
//  Created by Евгений on 13.09.2022.
//

import SwiftUI

struct BlackListScreen: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: "blocked_users", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 18))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            BlackListView()
                .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }
}

struct BlackListScreen_Previews: PreviewProvider {
    static var previews: some View {
        BlackListScreen()
    }
}
