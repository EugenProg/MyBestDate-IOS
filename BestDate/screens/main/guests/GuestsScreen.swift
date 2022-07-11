//
//  GuestsScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct GuestsScreen: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    MainHeaderImage()

                    Spacer()

                    Button(action: {
                        //store.dispatch(action: .navigate(screen: .PROFILE))
                    }) {
                        Image("ic_menu_dots")
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                    }
                }

                Title(textColor: ColorList.white.color, text: "guests", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 0, bottom: 16, trailing: 0))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("new_guests")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .padding(.init(top: 20, leading: 18, bottom: 5, trailing: 18))

                    Text("previous_views")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .padding(.init(top: 50, leading: 18, bottom: 5, trailing: 18))
                }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
            }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 60, trailing: 0))

        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
    }
}

struct GuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GuestsScreen()
    }
}
