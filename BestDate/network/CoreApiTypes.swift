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

    func getRequest(params: [RequestParams], body: Data? = nil) -> URLRequest {
        var request = self.request
        request.httpBody = body

        print("\n\(getMethod) \(BaseURL)\(getPath)\n\(String(describing: body))\n")
        return request
    }

    func getRequest(path: String, body: Data? = nil) -> URLRequest {
        var request = self.request
        request.httpBody = body

        print("\n\(getMethod) \(BaseURL)\(getPath)\n\(String(describing: body))\n")
        return request
    }


    func getRequest() -> URLRequest {
        print("\n\(getMethod) \(BaseURL)\(getPath)\n")
        return request
    }
}

struct RequestParams {
    var key: String = ""
    var value: String = ""
}
