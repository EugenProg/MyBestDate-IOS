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

struct SocialOAuthRequest: Codable {
    var grant_type: String = "social"
    var provider: String
    var access_token: String
}

struct RefreshTokenRequest: Codable {
    var grant_type: String = "refresh_token"
    var refresh_token: String
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
    var gender: String? = nil
    var filters: Filter? = nil
}

struct Filter: Codable {
    var location: FilterLocation
}

struct FilterLocation: Codable {
    var range: Int
    var lat: String
    var lng: String
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

struct MatchActionRequest: Codable {
    var user_id: Int
}

struct SendInvitationRequest: Codable {
    var invitation_id: Int
    var user_id: Int
}

struct AnswerTheInvitationRequest: Codable {
    var answer_id: Int
}

struct GetUserInvitationFilter: Codable {
    var filter: String
}

struct SaveSettingsRequest: Codable {
    var block_messages: Bool? = nil
    var matches: Bool? = nil
    var invisible: Bool? = nil
    var likes_notifications: Bool? = nil
    var matches_notifications: Bool? = nil
    var invitations_notifications: Bool? = nil
    var messages_notifications: Bool? = nil
    var guests_notifications: Bool? = nil
}

struct UpdateLanguageRequest: Codable {
    var language: String
}

struct UpdateUserDataRequest: Codable {
    var name: String
    var gender: String
    var birthday: String
    var look_for: [String]
}

struct SetUserLocationRequest: Codable {
    var lat: String
    var lng: String
    var iso_code: String
    var country: String
    var state: String? = nil
    var state_name: String? = nil
    var city: String
}

struct StoreTokenRequest: Codable {
    var type: String = "ios"
    var token: String
}

struct UpdateSubscriptionInfoRequest: Codable {
    var device: String = "ios"
    var start_at: String? = nil
    var end_at: String? = nil
}
