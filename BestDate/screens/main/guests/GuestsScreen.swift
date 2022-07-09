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
        VStack {
            Text("guests")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
    }
}

struct GuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GuestsScreen()
    }
}
