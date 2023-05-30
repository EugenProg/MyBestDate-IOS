//
//  CoreApiService.swift
//  BestDate
//
//  Created by Евгений on 04.07.2022.
//

import Foundation
import CoreLocation
import UIKit

class CoreApiService : NetworkRequest {
    static var shared = CoreApiService()

    func loginByEmail(userName: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.loginByEmail.getRequest()

        let body = LoginByEmailRequest(username: userName, password: password)
        makeRequest(request: request, body: body, type: AuthResponse.self) { response in
            if response?.error == nil {
                UserDataHolder.shared.setAuthData(response: response)
            }
            completion(response?.error == nil, response?.message ?? "wrong_auth_data".localized())
        }
    }

    func loginByPhone(phone: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.loginByPhone.getRequest()

        let body = LoginByPhoneRequest(phone: phone, password: password)
        makeRequest(request: request, body: body, type: AuthResponse.self) { response in
            if response?.error == nil {
                UserDataHolder.shared.setAuthData(response: response)
            }
            completion(response?.error == nil, response?.message ?? "wrong_auth_data".localized())
        }
    }

    func signInWithSocial(provider: SocialOAuthType, token: String, completion: @escaping (Bool, Bool) -> Void) {
        let request = CoreApiTypes.signInWithSocial.getRequest()

        let body = SocialOAuthRequest(provider: provider.rawValue, access_token: token)
        makeRequest(request: request, body: body, type: AuthResponse.self) { response in
            if response?.error == nil {
                UserDataHolder.shared.setAuthData(response: response)
            }
            completion(response?.error == nil, response?.registration == true)
        }
    }

    func registrEmail(email: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.registerEmail.getRequest()

        let body = SendCodeRequest(email: email)
        makeRequest(request: request, body: body, type: SendCodeResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }


    func registrUserEmail(email: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.registerUserEmail.getRequest(withAuth: true)

        let body = SendCodeRequest(email: email)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func registrPhone(phone: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.registerPhone.getRequest()

        let body = SendCodeRequest(phone: phone)
        makeRequest(request: request, body: body, type: SendCodeResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func registrUserPhone(phone: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.registerUserPhone.getRequest(withAuth: true)

        let body = SendCodeRequest(phone: phone)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func confirmEmail(email: String, code: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.confirmEmail.getRequest()

        let body = ConfirmRequest(email: email, code: code)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func confirmUserEmail(email: String, code: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.confirmUserEmail.getRequest(withAuth: true)

        let body = ConfirmRequest(email: email, code: code)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func confirmPhone(phone: String, code: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.confirmPhone.getRequest()

        let body = ConfirmRequest(phone: phone, code: code)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func confirmUserPhone(phone: String, code: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.confirmUserPhone.getRequest(withAuth: true)

        let body = ConfirmRequest(phone: phone, code: code)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? "")
        }
    }

    func registerByPhone(requestModel: RegistrationRequest, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.registerByPhone.getRequest()

        makeRequest(request: request, body: requestModel, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func registerByEmail(requestModel: RegistrationRequest, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.registerByEmail.getRequest()

        makeRequest(request: request, body: requestModel, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func resetEmail(email: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.resetEmail.getRequest()

        let body = SendCodeRequest(email: email)
        makeRequest(request: request, body: body, type: SendCodeResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func resetPhone(phone: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.resetPhone.getRequest()

        let body = SendCodeRequest(phone: phone)
        makeRequest(request: request, body: body, type: SendCodeResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func confirmEmailReset(email: String, code: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.confirmEmailReset.getRequest()

        let body = ConfirmRequest(email: email, code: code, password: password, password_confirmation: password)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func confirmPhoneReset(phone: String, code: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.confirmPhoneReset.getRequest()

        let body = ConfirmRequest(phone: phone, code: code, password: password, password_confirmation: password)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? getDefaultError())
        }
    }

    func getUserData(completion: @escaping (Bool, UserInfo) -> Void) {
        let request = CoreApiTypes.getUser.getRequest(withAuth: true)

        makeRequest(request: request, type: UserDataResponse.self) { response in
            UserDataHolder.shared.setUserInfo(user: response?.data)
            completion(response?.success == true, response?.data ?? UserInfo())
        }
    }

    func saveQuestionnaire(questionnaire: Questionnaire, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.saveQuestionnaire.getRequest(withAuth: true)

        makeRequest(request: request, body: questionnaire, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func getUsersList(location: LocationFilterTypes, online: OnlineFilterTypes,
                      filter: Filter? = nil, genderFilter: FilterGender, page: Int,
                      completion: @escaping (Bool, [ShortUserInfo], Meta) -> Void) {
        let request = CoreApiTypes.getUserList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        let location = location == .filter ? LocationFilterTypes.all : location
        let online = online == .filter ? OnlineFilterTypes.all : online
        let body = SearchFilter(location: location.rawValue, online: online.rawValue, gender: genderFilter.getServerName, filters: filter)

        makeRequest(request: request, body: body, type: UserListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta ?? Meta())
        }
    }

    func getUsersById(id: Int, completion: @escaping (Bool, UserInfo) -> Void) {
        let request = CoreApiTypes.getUserById.getRequest(path: id.toString(), withAuth: true)

        currentTask = makeTaskRequest(request: request, type: UserDataResponse.self) { response in
            completion(response?.success == true, response?.data ?? UserInfo())
            self.currentTask = nil
        }
    }

    func refreshToken(completion: @escaping (Bool) -> Void) {
        if currentTask != nil { return }
        let request = CoreApiTypes.refreshToken.getRequest()

        let body = RefreshTokenRequest(refresh_token: UserDataHolder.shared.getRefreshToken())
        currentTask = makeTaskRequest(request: request, body: body, type: AuthResponse.self) { response in
            if response?.error == nil {
                UserDataHolder.shared.setAuthData(response: response)
            }
            completion(response?.error == nil)
            self.currentTask = nil
        }
    }

    func logout(completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.logout.getRequest(withAuth: true)

        makeRequest(request: request, type: BaseResponse.self) { response in
            UserDataHolder.shared.clearUserData()
            completion(response?.success == true)
        }
    }

    func getGuests(page: Int, completion: @escaping (Bool, [Guest], Meta) -> Void) {
        let request = CoreApiTypes.getGuestList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        makeRequest(request: request, type: GuestListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta ?? Meta())
        }
    }

    func setGuestViewed(ids: [Int], completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.setViewedAction.getRequest(withAuth: true)

        let body = IdListRequest(ids: ids)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func blockUser(id: Int?, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.blockUser.getRequest(path: (id ?? 0).toString(), withAuth: true)

        makeRequest(request: request, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func unlockUser(id: Int?, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.unlockUser.getRequest(path: (id ?? 0).toString(), withAuth: true)

        makeRequest(request: request, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func getBlockedList(completion: @escaping (Bool, [ShortUserInfo]) -> Void) {
        let request = CoreApiTypes.getBlockedList.getRequest(withAuth: true)

        makeRequest(request: request, type: UserListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [])
        }
    }

    func compline(id: Int?, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.compline.getRequest(withAuth: true)

        let body = MatchActionRequest(user_id: id ?? 0)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func getUserSettings(completion: @escaping (Bool, UserSettings) -> Void) {
        let request = CoreApiTypes.getUserSettings.getRequest(withAuth: true)

        makeRequest(request: request, type: UserSettingsResponse.self) { response in
            UserDataHolder.shared.setMatchesEnabled(enabled: response?.data?.matches == true)
            UserDataHolder.shared.setChatEnabled(enabled: response?.data?.block_messages == false)
            completion(response?.success == true, response?.data ?? UserSettings())
        }
    }

    func saveSettings(model: SaveSettingsRequest, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.saveSettings.getRequest(withAuth: true)

        makeRequest(request: request, body: model, type: UserSettingsResponse.self) { response in
            UserDataHolder.shared.setMatchesEnabled(enabled: response?.data?.matches == true)
            UserDataHolder.shared.setChatEnabled(enabled: response?.data?.block_messages == false)
            completion(response?.success == true)
        }
    }

    func updateLanguage(lang: String, completion: @escaping (Bool, UserInfo) -> Void) {
        let request = CoreApiTypes.updateLanguage.getRequest(withAuth: true)

        let body = UpdateLanguageRequest(language: lang)
        makeRequest(request: request, body: body, type: UserDataResponse.self) { response in
            UserDataHolder.shared.setUserInfo(user: response?.data)
            completion(response?.success == true, response?.data ?? UserInfo())
        }
    }

    func updateUserData(data: UpdateUserDataRequest, completion: @escaping (Bool, UserInfo) -> Void) {
        let request = CoreApiTypes.updateUserData.getRequest(withAuth: true)

        makeRequest(request: request, body: data, type: UserDataResponse.self) { response in
            UserDataHolder.shared.setUserInfo(user: response?.data)
            completion(response?.success == true, response?.data ?? UserInfo())
        }
    }

    func deleteUserProfile(completion: @escaping () -> Void) {
        let request = CoreApiTypes.deleteUserProfile.getRequest(withAuth: true)

        makeRequest(request: request, type: BaseResponse.self) { _ in
            UserDataHolder.shared.clearUserData()
            completion()
        }
    }

    func changePassword(oldPass: String, newPass: String, completion: @escaping (Bool, String) -> Void) {
        let request = CoreApiTypes.changePassword.getRequest(withAuth: true)

        let body = ChangePasswordRequest(old_password: oldPass, password: newPass, password_confirmation: newPass)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true, response?.message ?? "")
        }
    }

    func saveUserLocation(location: SetUserLocationRequest, completion: @escaping (Bool, UserInfo) -> Void) {
        let request = CoreApiTypes.saveUserLocation.getRequest(withAuth: true)

        makeRequest(request: request, body: location, type: UserDataResponse.self) { response in
            UserDataHolder.shared.setUserInfo(user: response?.data ?? UserInfo())
            completion(response?.success == true, response?.data ?? UserInfo())
        }
    }

    func storeDeviceToken(token: String) {
        let request = CoreApiTypes.deviceToken.getRequest(withAuth: true)

        let body = StoreTokenRequest(token: token)
        makeRequest(request: request, body: body, type: BaseResponse.self) { _ in }
    }
}

fileprivate func getDefaultError() -> String {
    "default_error_message".localized()
}
