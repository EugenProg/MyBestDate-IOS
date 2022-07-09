//
//  TopScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct TopScreen: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            Text("top_50")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.blue.color.edgesIgnoringSafeArea(.bottom))
    }
}

struct TopScreen_Previews: PreviewProvider {
    static var previews: some View {
        TopScreen()
    }
}
