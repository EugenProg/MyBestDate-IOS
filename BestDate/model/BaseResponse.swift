//
//  BaseResponse.swift
//  BestDate
//
//  Created by Евгений on 06.07.2022.
//

import Foundation

struct BaseResponse: Codable {
    var success: Bool
    var message: String
}

struct ProfileImageResponse: Codable {
    var success: Bool
    var message: String
    var data: ProfileImage? = nil
}

struct ProfileImage: Codable {
    var id: Int? = nil
    var full_url: String? = nil
    var thumb_url: String? = nil
    var main: Bool? = nil
    var top: Bool? = nil
    var liked: Bool? = nil
}

struct UserDataResponse: Codable {
    var success: Bool
    var message: String
    var data: UserInfo? = nil
}

struct ShortUserDataResponse: Codable {
    var success: Bool
    var message: String
    var data: ShortUserInfo? = nil
}

struct UserInfo: Codable {
    var id: Int? = nil
    var name: String? = nil
    var email: String? = nil
    var email_verification: Bool? = nil
    var phone: String? = nil
    var phone_verification: Bool? = nil
    var gender: String? = nil
    var look_for: [String]? = nil
    var language: String? = nil
    var birthday: String? = nil
    var is_online: Bool? = nil
    var last_online_at: String? = nil
    var new_likes: Int? = nil
    var new_guests: Int? = nil
    var distance: Double? = nil
    var photos: [ProfileImage]? = nil
    var location: Location? = nil
    var questionnaire: Questionnaire? = nil
}

struct ShortUserInfo: Codable {
    var id: Int? = nil
    var name: String? = nil
    var gender: String? = nil
    var birthday: String? = nil
    var main_photo: ProfileImage? = nil
    var is_online: Bool? = nil
    var last_online_at: String? = nil
    var occupation: String? = nil
    var full_questionnaire: Bool? = nil
    var distance: Double? = nil
}

struct Questionnaire: Codable {
    var purpose: String? = nil
    var expectations: String? = nil
    var height: Int? = nil
    var weight: Int? = nil
    var eye_color: String? = nil
    var hair_color: String? = nil
    var hair_length: String? = nil
    var marital_status: String? = nil
    var kids: String? = nil
    var education: String? = nil
    var occupation: String? = nil
    var nationality: String? = nil
    var search_country: String? = nil
    var search_city: String? = nil
    var about_me: String? = nil
    var search_age_min: Int? = nil
    var search_age_max: Int? = nil
    var socials: [String]? = []
    var hobby: [String]? = []
    var sport: [String]? = []
    var evening_time: String? = nil
}

struct Location: Codable {
    var iso_code: String? = nil
    var country: String? = nil
    var city: String? = nil
}

struct UserListResponse: Codable {
    var success: Bool
    var message: String
    var data: [ShortUserInfo] = []
}

struct ChatListResponse: Codable {
    var success: Bool
    var message: String
    var data: [Chat] = []
}

struct Chat: Codable {
    var id: Int? = nil
    var user: ShortUserInfo? = nil
    var last_message: Message? = nil
}

struct Message: Codable {
    var id: Int? = nil
    var sender_id: Int? = nil
    var recipient_id: Int? = nil
    var parent_id: Int? = nil
    var text: String? = nil
    var media: String? = nil
    var read_at: String? = nil
    var created_at: String? = nil
}

struct SendMessageResponse: Codable {
    var success: Bool
    var message: String
    var data: Message? = nil
}

struct GetChatMessagesResponse: Codable {
    var success: Bool
    var message: String
    var data: [Message] = []
}

struct GuestListResponse: Codable {
    var success: Bool
    var message: String
    var data: [Guest] = []
}

struct Guest: Codable {
    var id: Int? = nil
    var visit_at: String? = nil
    var viewed: Bool? = nil
    var guest: ShortUserInfo? = nil
}

struct TopListResponse: Codable {
    var success: Bool
    var message: String
    var data: [Top] = []
}

struct Top: Codable {
    var id: Int? = nil
    var full_url: String? = nil
    var thumb_url: String? = nil
    var rating: Double? = nil
    var user: ShortUserInfo? = nil
}

struct MyDuelsListResponse: Codable {
    var success: Bool
    var message: String
    var data: [MyDuel] = []
}

struct MyDuel: Codable {
    var id: Int? = nil
    var created_at: String? = nil
    var winning_photo: ProfileImage? = nil
    var loser_photo: ProfileImage? = nil
    var voter: ShortUserInfo? = nil
}
