//
//  ChangePasswordMediator.swift
//  BestDate
//
//  Created by Евгений on 22.09.2022.
//

import Foundation

class ChangePasswordMediator: ObservableObject {
    static var shared = ChangePasswordMediator()

    func saveNewPassword(oldPass: String, newPass: String, completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.changePassword(oldPass: oldPass, newPass: newPass) { success, message in
            completion(success, message)
        }
    }
}
