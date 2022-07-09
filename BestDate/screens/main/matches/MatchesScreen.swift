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
        VStack {
            Text("mathces")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.pink.color.edgesIgnoringSafeArea(.bottom))
    }
}

struct MatchesScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatchesScreen()
    }
}
