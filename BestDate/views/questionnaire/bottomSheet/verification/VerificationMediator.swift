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
    @Published var socialNetworkes: [SocialNet] = []

    @Published var instaInput: String = ""
    @Published var faceInput: String = ""
    @Published var twitInput: String = ""
    @Published var linkInput: String = ""

    @Published var instaError: Bool = false
    @Published var faceError: Bool = false
    @Published var twitError: Bool = false
    @Published var linkError: Bool = false

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

    func isValid() -> Bool {
        if SocialTypes.getSocialTypeByLink(link: instaInput) != .insta && !instaInput.isEmpty {
            instaError = true
            return false
        } else if SocialTypes.getSocialTypeByLink(link: faceInput) != .facebook && !faceInput.isEmpty {
            faceError = true
            return false
        } else if SocialTypes.getSocialTypeByLink(link: twitInput) != .twitter && !twitInput.isEmpty {
            twitError = true
            return false
        } else if SocialTypes.getSocialTypeByLink(link: linkInput) != .linkedin && !linkInput.isEmpty {
            linkError = true
            return false
        } else {
            return true
        }
    }

    func setQuestionInfo(questionInfo: QuestionInfo) {
        self.questionInfo = questionInfo
        setAnsfers(ansfers: questionInfo.selectedAnsfer)
    }

    func setAnsfers(ansfers: String) {
        socialNetworkes.removeAll()
        for ansfer in ansfers.components(separatedBy: ", ") {
            socialNetworkes.append(
                SocialNet(type: SocialTypes.getSocialTypeByLink(link: ansfer),
                          link: ansfer)
            )
        }
    }

    func getAnsferLine() -> String {
        var line = ""

        if !instaInput.isEmpty {
            line.append("\(instaInput), ")
        }
        if !faceInput.isEmpty {
            line.append("\(faceInput), ")
        }
        if !twitInput.isEmpty {
            line.append("\(twitInput), ")
        }
        if !linkInput.isEmpty {
            line.append("\(linkInput), ")
        }

        if !line.isEmpty {
            line = String(line.prefix(line.count - 2))
        }

        return line
    }
}

struct SocialNet {
    var type: SocialTypes
    var link: String
}

enum SocialTypes {
    case insta
    case facebook
    case twitter
    case linkedin
    case unknown

    var image: String {
        switch self {
        case .insta: return "ic_insta"
        case .facebook: return "ic_facebook_logo"
        case .twitter: return "ic_twitter"
        case .linkedin: return "ic_linkedin"
        case .unknown: return ""
        }
    }

    static func getSocialTypeByLink(link: String) -> SocialTypes {
        if link.contains("instagram.com") { return .insta }
        else if link.contains("facebook.com") { return .facebook }
        else if link.contains("twitter.com") { return .twitter }
        else if link.contains("linkedin.com") { return .linkedin }
        else { return .unknown }
    }
}
