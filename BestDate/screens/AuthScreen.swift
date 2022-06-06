//
//  AuthScreen.swift
//  BestDate
//
//  Created by Евгений on 06.06.2022.
//

import SwiftUI

struct AuthScreen: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ZStack {
            TextButton(text: "Hello", textColor: ColorList.pink.color) {
                store.dispatch(action: .navigationBack)
            }
        }.background(ColorList.white.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.white.color, style: .darkContent))
        }
    }
}

struct AuthScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthScreen()
    }
}
