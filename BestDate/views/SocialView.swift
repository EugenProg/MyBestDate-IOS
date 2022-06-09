//
//  SocialView.swift
//  BestDate
//
//  Created by Евгений on 09.06.2022.
//

import SwiftUI

struct SocialView: View {
    @EnvironmentObject var store: Store
    var gooleClickAction: () -> Void
    var appleClickAction: () -> Void
    var facebookClickAction: () -> Void
    
    fileprivate func button(image: String, clickAction: @escaping () -> Void) -> some View {
        Button(action: {
            withAnimation { clickAction() }
        }) {
            ZStack {
                Image("shadow")
                    .resizable()
                    .frame(width: 80, height: 80)
                Image(image)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(ColorList.main.color)
                .cornerRadius(radius: 35, corners: [.topLeft, .topRight])
                .shadow(color: MyColor.getColor(17, 24, 28, 0.63), radius: 46, y: -7)
        
            HStack(spacing: 5) {
                button(image: "ic_facebook", clickAction: facebookClickAction)
                button(image: "ic_apple", clickAction: appleClickAction)
                button(image: "ic_google", clickAction: gooleClickAction)
            }
        }.frame(width: UIScreen.main.bounds.width, height: 100 + store.state.statusBarHeight, alignment: .top)
            .background(ColorList.main.color)
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView(gooleClickAction: {}, appleClickAction: {}, facebookClickAction: {})
    }
}
