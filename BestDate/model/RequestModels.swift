//
//  RequestModels.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

struct LoginByEmailRequest: Codable {
    var username: String
    var password: String
    var grant_type: String = "password"
}

struct LoginByPhoneRequest: Codable {
    var phone: String
    var password: String
    var grant_type: String = "phone"
}

struct RefreshTokenRequest: Codable {
    var grant_type: String = "refresh_token"
    var refresh_token: String
}

struct LoginSociableRequest: Codable {
    var provider: String
    var access_token: String
    var grant_type: String = "social"
}

struct SendCodeRequest: Codable {
    var email: String? = nil
    var phone: String? = nil
}

struct ConfirmRequest: Codable {
    var email: String? = nil
    var phone: String? = nil
    var code: String
    var password: String? = nil
    var password_confirmation: String? = nil
}

struct RegistrationRequest: Codable {
    var email: String? = nil
    var phone: String? = nil
    var name: String
    var password: String
    var password_confirmation: String
    var gender: String
    var language: String = "en"
    var birthday: String
    var look_for: [String]
}

struct IdListRequest: Codable {
    var ids: [Int]
}

struct PhotoStatusUpdateRequest: Codable {
    var main: Bool? = nil
    var top: Bool? = nil
}

struct SearchFilter: Codable {
    var location: String = "all"
    var online: String = "all"
}

struct SendMessageRequest: Codable {
    var text: String
}

struct TopRequest: Codable {
    var gender: String
    var country: String? = nil
}

struct VotePhotos: Codable {
    var winning_photo: Int
    var loser_photo: Int
}

struct PhotoLikeRequest: Codable {
    var photo_id: Int
}
