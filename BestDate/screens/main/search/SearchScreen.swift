//
//  SearchScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct SearchScreen: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            Text("search")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.white.color.edgesIgnoringSafeArea(.bottom))
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
