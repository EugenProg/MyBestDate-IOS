//
//  OnboardStartScreen.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import SwiftUI

struct OnboardStartScreen: View {
    @EnvironmentObject var store: Store
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Image("ic_decor")
            VStack(spacing: 0) {
                HStack {
                    Image("ic_logoName")
                    Spacer()
                    TextButton(text: "Skip", textColor: ColorList.white.color) {
                        store.dispatch(action: .navigate(screen: .AUTH))
                    }
                }.padding(.init(top: 32, leading: 32, bottom: 0, trailing: 32))
                Spacer()
            }.frame(height: height)
            
            let halfHeight = height / 2
            let offsetHeight = (halfHeight - 250) / 2
            
            VStack(spacing: 0) {
                Image("ic_couple_first")
                    .resizable()
                    .frame(width: 250, height: 250)
            }.padding(.init(top: offsetHeight, leading: 0, bottom: halfHeight + offsetHeight, trailing: 0))
            
        }.background(ColorList.pink.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }
}

struct OnboardStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardStartScreen()
    }
}
