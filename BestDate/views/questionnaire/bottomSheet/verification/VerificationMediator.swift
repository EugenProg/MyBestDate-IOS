//
//  VerificationMediator.swift
//  BestDate
//
//  Created by Евгений on 17.08.2022.
//

import Foundation

class VerificationMediator: ObservableObject {
    static var shared = VerificationMediator()

    @Published var questionInfo: QuestionInfo = QuestionInfo(id: 0)

    func getEmailCode(email: String, completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.registrUserEmail(email: email) { success, message in
            completion(success, message)
        }
    }

    func confirmEmail(email: String, code: String, completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.confirmUserEmail(email: email, code: code) { success, message in
            DispatchQueue.main.async {
                if success { self.questionInfo.selectAction!(email) }
            }
            completion(success, message)
        }
    }

    func getPhoneCode(phone: String, completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.registrUserPhone(phone: phone) { success, message in
            completion(success, message)
        }

    }

    func confirmPhone(phone: String, code: String, completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.confirmUserPhone(phone: phone, code: code) { success, message in
            DispatchQueue.main.async {
                if success { self.questionInfo.selectAction!(phone) }
            }
            completion(success, message)
        }
    }
}
