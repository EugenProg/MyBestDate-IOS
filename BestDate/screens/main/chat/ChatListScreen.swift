//
//  ChatListScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct ChatListScreen: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            Text("messages")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.gray.color.edgesIgnoringSafeArea(.bottom))
    }
}

struct ChatListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatListScreen()
    }
}
