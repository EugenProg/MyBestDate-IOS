//
//  CoreApiService.swift
//  BestDate
//
//  Created by Евгений on 04.07.2022.
//

import Foundation

enum CoreApiTypes {
    case loginByPhone
    case loginByEmail

    case registerEmail
    case registerPhone
    case confirmEmail
    case confirmPhone
    case registerByEmail
    case registerByPhone

    case resetEmail
    case resetPhone
    case confirmEmailReset
    case confirmPhoneReset

    case saveImage
    case deleteImage
    case updateImageStatus

    case getUser
    case saveQuestionnaire

    case getUserList
    case getUserById

    case refreshToken

    case getChatList
    case deleteChat
    case sendMessage
    case updateMessage
    case deleteMessage

    case getGuestList
    case setViewedAction

    case getUserLikes
    case likeAPhoto

    case getTopList
    case voteAction
    case getVotingPhotos
    case getMyVoits

    case registerUserEmail
    case registerUserPhone
    case confirmUserEmail
    case confirmUserPhone

    case updateUserData

    case logout

    var BaseURL: String {
        "https://dev-api.bestdate.info/api/v1/"
    }

    var getPath: String {
        switch self {
        case .loginByPhone: return "login-phone"
        case .loginByEmail: return "login-email"
        case .registerEmail: return "email/send-code"
        case .registerPhone: return "phone/send-code"
        case .confirmEmail: return "email/confirm-code"
        case .confirmPhone: return "phone/confirm-code"
        case .registerByEmail: return "email/register"
        case .registerByPhone: return "phone/register"
        case .resetEmail: return "email/password-reset-send-code"
        case .resetPhone: return "phone/password-reset-send-code"
        case .confirmEmailReset: return "email/password-reset-by-code"
        case .confirmPhoneReset: return "phone/password-reset-by-code"
        case .saveImage: return "user/photos"
        case .deleteImage: return "user/photos"
        case .updateImageStatus: return "user/photos/"
        case .getUser: return "user"
        case .saveQuestionnaire: return "user/questionnaire"
        case .getUserList: return "users"
        case .getUserById: return "users/"
        case .refreshToken: return "refresh-token"
        case .getChatList: return "chats"
        case .deleteChat: return "chat/"
        case .sendMessage: return "message"
        case .updateMessage: return "message/"
        case .deleteMessage: return "message/"
        case .getGuestList: return "guests"
        case .setViewedAction: return "guests"
        case .getUserLikes: return "likes"
        case .likeAPhoto: return "likes"
        case .getTopList: return "top"
        case .voteAction: return "voting"
        case .getMyVoits: return "voting"
        case .getVotingPhotos: return "voting-photos"
        case .registerUserEmail: return "user/email-code"
        case .registerUserPhone: return "user/phone-code"
        case .confirmUserEmail: return "user/email"
        case .confirmUserPhone: return "user/phone"
        case .updateUserData: return "user"
        case .logout: return "logout"

        }
    }

    var getMethod: String {
        switch self {
        case .loginByPhone: return "POST"
        case .loginByEmail: return "POST"
        case .registerEmail: return "POST"
        case .registerPhone: return "POST"
        case .confirmEmail: return "POST"
        case .confirmPhone: return "POST"
        case .registerByEmail: return "POST"
        case .registerByPhone: return "POST"
        case .resetEmail: return "POST"
        case .resetPhone: return "POST"
        case .confirmEmailReset: return "POST"
        case .confirmPhoneReset: return "POST"
        case .saveImage: return "POST"
        case .deleteImage: return "DELETE"
        case .updateImageStatus: return "PUT"
        case .getUser: return "GET"
        case .saveQuestionnaire: return "PUT"
        case .getUserList: return "POST"
        case .getUserById: return "GET"
        case .refreshToken: return "POST"
        case .getChatList: return "GET"
        case .deleteChat: return "DELETE"
        case .sendMessage: return "POST"
        case .updateMessage: return "PUT"
        case .deleteMessage: return "DELETE"
        case .getGuestList: return "GET"
        case .setViewedAction: return "PUT"
        case .getUserLikes: return "GET"
        case .likeAPhoto: return "POST"
        case .getTopList: return "POST"
        case .voteAction: return "POST"
        case .getMyVoits: return "GET"
        case .getVotingPhotos: return "POST"
        case .registerUserEmail: return "POST"
        case .registerUserPhone: return "POST"
        case .confirmUserEmail: return "PUT"
        case .confirmUserPhone: return "PUT"
        case .updateUserData: return "PUT"
        case .logout: return "GET"
        }
    }

    var request: URLRequest {
        let url = URL(string: getPath, relativeTo: URL(string: BaseURL)!)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("en", forHTTPHeaderField: "X-Localization")
        request.httpMethod = getMethod
        return request
    }

    func getRequest(params: [RequestParams], withAuth: Bool? = nil) -> URLRequest {
        var request = self.request

        print("\n\(getMethod) \(BaseURL)\(getPath)\n")
        return request
    }

    func getRequest(path: String, withAuth: Bool? = nil) -> URLRequest {
        let url = URL(string: getPath + path, relativeTo: URL(string: BaseURL)!)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("en", forHTTPHeaderField: "X-Localization")
        if withAuth == true {
            request.setValue(UserDataHolder.accessToken, forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = getMethod

        print("\n\(getMethod) \(BaseURL)\(getPath + path)\n")
        return request
    }


    func getRequest(withAuth: Bool? = nil) -> URLRequest {
        print("\n\(getMethod) \(BaseURL)\(getPath)\n")
        var request = self.request
        if withAuth == true {
            request.setValue(UserDataHolder.accessToken, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

struct RequestParams {
    var key: String = ""
    var value: String = ""
}