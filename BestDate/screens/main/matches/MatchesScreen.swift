//
//  MatchesScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct MatchesScreen: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button(action: {
                        //store.dispatch(action: .navigate(screen: .PROFILE))
                    }) {
                        MainHeaderImage()
                    }

                    Spacer()

                    Button(action: {
                        //store.dispatch(action: .navigate(screen: .PROFILE))
                    }) {
                        Image("ic_menu_dots")
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                    }
                }

                Title(textColor: ColorList.white.color, text: "matches", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 0, bottom: 16, trailing: 0))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            Spacer()
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
    }
}

struct MatchesScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatchesScreen()
    }
}
