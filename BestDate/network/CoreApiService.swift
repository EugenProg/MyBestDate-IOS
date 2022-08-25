//
//  CoreApiService.swift
//  BestDate
//
//  Created by Евгений on 04.07.2022.
//

import Foundation
import CoreLocation
import UIKit

class CoreApiService {
    static var shared = CoreApiService()
    private let encoder = JSONEncoder()

    func loginByEmail(userName: String, password: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.loginByEmail.getRequest()

        let data = try! encoder.encode(LoginByEmailRequest(username: userName, password: password))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(AuthResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                UserDataHolder.setAuthData(response: response)
                completion(true)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func loginByPhone(phone: String, password: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.loginByPhone.getRequest()

        let data = try! encoder.encode(LoginByPhoneRequest(phone: phone, password: password))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(AuthResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                UserDataHolder.setAuthData(response: response)
                completion(true)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func registrEmail(email: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.registerEmail.getRequest()

        let data = try! encoder.encode(SendCodeRequest(email: email))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }


    func registrUserEmail(email: String, completion: @escaping (Bool, String) -> Void) {
        var request = CoreApiTypes.registerUserEmail.getRequest(withAuth: true)

        let data = try! encoder.encode(SendCodeRequest(email: email))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.message)
            } else {
                completion(false, "")
            }
        }

        task.resume()
    }

    func registrPhone(phone: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.registerPhone.getRequest()

        let data = try! encoder.encode(SendCodeRequest(phone: phone))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func registrUserPhone(phone: String, completion: @escaping (Bool, String) -> Void) {
        var request = CoreApiTypes.registerUserPhone.getRequest(withAuth: true)

        let data = try! encoder.encode(SendCodeRequest(phone: phone))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.message)
            } else {
                completion(false, "")
            }
        }

        task.resume()
    }

    func confirmEmail(email: String, code: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.confirmEmail.getRequest()

        let data = try! encoder.encode(ConfirmRequest(email: email, code: code))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func confirmUserEmail(email: String, code: String, completion: @escaping (Bool, String) -> Void) {
        var request = CoreApiTypes.confirmUserEmail.getRequest(withAuth: true)

        let data = try! encoder.encode(ConfirmRequest(email: email, code: code))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.message)
            } else {
                completion(false, "")
            }
        }

        task.resume()
    }

    func confirmPhone(phone: String, code: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.confirmPhone.getRequest()

        let data = try! encoder.encode(ConfirmRequest(phone: phone, code: code))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func confirmUserPhone(phone: String, code: String, completion: @escaping (Bool, String) -> Void) {
        var request = CoreApiTypes.confirmUserPhone.getRequest(withAuth: true)

        let data = try! encoder.encode(ConfirmRequest(phone: phone, code: code))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.message)
            } else {
                completion(false, "")
            }
        }

        task.resume()
    }

    func registerByPhone(requestModel: RegistrationRequest, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.registerByPhone.getRequest()

        let data = try! encoder.encode(requestModel)
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func registerByEmail(requestModel: RegistrationRequest, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.registerByEmail.getRequest()

        let data = try! encoder.encode(requestModel)
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func resetEmail(email: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.resetEmail.getRequest()

        let data = try! encoder.encode(SendCodeRequest(email: email))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func resetPhone(phone: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.resetPhone.getRequest()

        let data = try! encoder.encode(SendCodeRequest(phone: phone))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func confirmEmailReset(email: String, code: String, password: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.confirmEmailReset.getRequest()

        let data = try! encoder.encode(ConfirmRequest(email: email, code: code, password: password, password_confirmation: password))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func confirmPhoneReset(phone: String, code: String, password: String, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.confirmPhoneReset.getRequest()

        let data = try! encoder.encode(ConfirmRequest(phone: phone, code: code, password: password, password_confirmation: password))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func getUserData(completion: @escaping (Bool, UserInfo) -> Void) {
        let request = CoreApiTypes.getUser.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(UserDataResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data ?? UserInfo())
            } else {
                completion(false, UserInfo())
            }
        }

        task.resume()
    }

    func saveQuestionnaire(questionnaire: Questionnaire, completion: @escaping (Bool, UserInfo) -> Void) {
        var request = CoreApiTypes.saveQuestionnaire.getRequest(withAuth: true)

        let data = try! encoder.encode(questionnaire)
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(UserDataResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data ?? UserInfo())
            } else {
                completion(false, UserInfo())
            }
        }

        task.resume()
    }

    func getUsersList(location: LocationFilterTypes, online: OnlineFilterTypes, page: Int, completion: @escaping (Bool, [ShortUserInfo], Meta) -> Void) {
        var request = CoreApiTypes.getUserList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        let data = try! encoder.encode(SearchFilter(location: location.rawValue, online: online.rawValue))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(UserListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data, response.meta ?? Meta())
            } else {
                completion(false, [], Meta())
            }
        }

        task.resume()
    }

    func getUsersById(id: Int, completion: @escaping (Bool, UserInfo) -> Void) {
        let request = CoreApiTypes.getUserById.getRequest(path: id.toString(), withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(UserDataResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data ?? UserInfo())
            } else {
                completion(false, UserInfo())
            }
        }

        task.resume()
    }

    func refreshToken(completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.refreshToken.getRequest()

        let data = try! encoder.encode(RefreshTokenRequest(refresh_token: UserDataHolder.refreshToken))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(AuthResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                UserDataHolder.setAuthData(response: response)
                completion(true)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func logout(completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.logout.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let _ = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                UserDataHolder.setAuthData(response: AuthResponse(token_type: "", expires_in: 0, access_token: "", refresh_token: ""))
                completion(true)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func getGuests(completion: @escaping (Bool, [Guest]) -> Void) {
        let request = CoreApiTypes.getGuestList.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(GuestListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }

    func setGuestViewed(ids: [Int], completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.setViewedAction.getRequest(withAuth: true)

        let data = try! encoder.encode(IdListRequest(ids: ids))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func blockUser(id: Int?, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.blockUser.getRequest(path: (id ?? 0).toString(), withAuth: true)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func unlockUser(id: Int?, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.unlockUser.getRequest(path: (id ?? 0).toString(), withAuth: true)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func getBlockedList(completion: @escaping (Bool, [ShortUserInfo]) -> Void) {
        let request = CoreApiTypes.getBlockedList.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(UserListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }
}
