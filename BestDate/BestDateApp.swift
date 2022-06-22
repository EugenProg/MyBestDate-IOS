//
//  BestDateApp.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import SwiftUI
import Combine
import UIKit

//2CCdsuQKSMezP5r5crKu

@main
struct BestDateApp: App {
    var body: some Scene {
        WindowGroup {
            let state = AppState()
            let reducer = Reducer()
            let store = Store(state: state, reducer: reducer)
            NavigationView().environmentObject(store)
        }
    }
}
