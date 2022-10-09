//
//  NotifySettingsMediator.swift
//  BestDate
//
//  Created by Евгений on 25.09.2022.
//

import Foundation

class NotifySettingsMediator: ObservableObject {
    static var shared = NotifySettingsMediator()

    func saveSettings(enable: Bool, completion: @escaping () -> Void) {
        CoreApiService.shared.saveSettings(model: SaveSettingsRequest(block_messages: enable)) { success in
            completion()
        }
    }
}
