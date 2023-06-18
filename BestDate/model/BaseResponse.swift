//
//  BaseResponse.swift
//  BestDate
//
//  Created by Евгений on 06.07.2022.
//

import Foundation

struct BaseResponse: Codable {
    var success: Bool
    var message: String? = nil
}

struct Meta: Codable {
    var current_page: Int? = nil
    var from: Int? = nil
    var last_page: Int? = nil
    var per_page: Int? = nil
    var to: Int? = nil
    var total: Int? = nil
}

struct SendCodeResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: Expirition? = nil
}

struct Expirition: Codable {
    var timer: Int
}

struct ProfileImageResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: ProfileImage? = nil
}

struct ProfileImage: Codable {
    var id: Int? = nil
    var full_url: String? = nil
    var thumb_url: String? = nil
    var main: Bool? = nil
    var top: Bool? = nil
    var liked: Bool? = nil
    var likes: Int? = nil
    var top_place: Int? = nil
    var moderated: Bool? = nil
}

struct UserDataResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: UserInfo? = nil
}

struct ShortUserDataResponse: Codable {
    var success: Bool
    var message: String? = nil
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
    var new_messages: Int? = nil
    var new_invitations: Int? = nil
    var new_duels: Int? = nil
    var new_matches: Int? = nil
    var coins: String? = nil
    var distance: Double? = nil
    var photos: [ProfileImage]? = nil
    var location: Location? = nil
    var block_messages: Bool? = nil
    var blocked: Bool? = nil
    var allow_chat: Bool? = nil
    var role: String? = nil
    var blocked_me: Bool? = nil
    var questionnaire: Questionnaire? = nil
    var sent_messages_today: Int? = nil
    var sent_invitations_today: Int? = nil
}

enum UserRole: String {
    case bot
    case user
}

struct ShortUserInfo: Codable {
    var id: Int? = nil
    var name: String? = nil
    var gender: String? = nil
    var birthday: String? = nil
    var main_photo: ProfileImage? = nil
    var is_online: Bool? = nil
    var last_online_at: String? = nil
    var location: Location? = nil
    var language: String? = nil
    var blocked: Bool? = nil
    var blocked_me: Bool? = nil
    var allow_chat: Bool? = nil
    var full_questionnaire: Bool? = nil
    var role: String? = nil
    var distance: Double? = nil
    var photos_count: Int? = nil
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
    var message: String? = nil
    var data: [ShortUserInfo] = []
    var meta: Meta? = nil
}

struct ChatListResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: [Chat] = []
    var meta: Meta? = nil
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
    var image: ChatImage? = nil
    var read_at: String? = nil
    var created_at: String? = nil
    var translatedMessage: String? = nil
    var translationStatus: TranslateButtonStatus? = .un_active
    var sent_messages_today: Int? = nil
}

struct SocketMessage: Codable {
    var id: Int? = nil
    var message: Message? = nil
}

struct ReadMessage: Codable {
    var id: Int? = nil
    var last_message: Message? = nil
}

struct TypingEventResponse: Codable {
    var id: Int
    var sender_id: Int
}

struct CoinsEventResponse: Codable {
    var id: Int
    var coins: String
}

struct ChatImage: Codable {
    var id: Int? = nil
    var full_url: String? = nil
    var thumb_url: String? = nil
}

struct SendMessageResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: Message? = nil
}

struct GetChatMessagesResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: [Message] = []
    var meta: Meta? = nil
}

struct GuestListResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: [Guest] = []
    var meta: Meta? = nil
}

struct Guest: Codable {
    var id: Int? = nil
    var visit_at: String? = nil
    var viewed: Bool? = nil
    var guest: ShortUserInfo? = nil
}

struct TopListResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: [Top] = []
    var meta: Meta? = nil
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
    var message: String? = nil
    var data: [MyDuel] = []
    var meta: Meta? = nil
}

struct MyDuel: Codable {
    var id: Int? = nil
    var created_at: String? = nil
    var winning_photo: ProfileImage? = nil
    var loser_photo: ProfileImage? = nil
    var voter: ShortUserInfo? = nil
}

struct InvitationCard: Codable {
    var id: Int? = nil
    var invitation: Invitation? = nil
    var from_user: ShortUserInfo? = nil
    var to_user: ShortUserInfo? = nil
    var answer: Invitation? = nil
    var sent_invitations_today: Int? = nil
}

struct Invitation: Codable {
    var id: Int? = nil
    var name: String? = nil
}

struct SendInvitationResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: InvitationCard? = nil
}

struct TranslationResponse: Codable {
    var translations: [Translation]? = []
}

struct Translation: Codable {
    var detected_source_language: String? = nil
    var text: String? = nil
}

struct InvitationListResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: [Invitation] = []
}

struct UserInvitationListResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: [InvitationCard] = []
    var meta: Meta? = nil
}

struct MatchesListResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: [Match] = []
    var meta: Meta? = nil
}

struct MatchResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: Match? = nil
}

struct Match: Codable {
    var id: Int? = nil
    var viewed: Bool? = nil
    var matched: Bool? = nil
    var user: ShortUserInfo? = nil
    var created_at: String? = nil
}

struct Like: Codable {
    var id: Int? = nil
    var created_at: String? = nil
    var photo: ProfileImage? = nil
    var user: ShortUserInfo? = nil
}

struct LikesListResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: [Like] = []
    var meta: Meta? = nil
}

struct UserSettingsResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: UserSettings? = nil
}

struct UserSettings: Codable {
    var user_id: Int? = nil
    var block_messages: Bool? = nil
    var matches: Bool? = nil
    var invisible: Bool? = nil
    var language: String? = nil
    var notifications: NotificationSettings = NotificationSettings()
}

struct NotificationSettings: Codable {
    var likes: Bool? = nil
    var matches: Bool? = nil
    var invitations: Bool? = nil
    var messages: Bool? = nil
    var guests: Bool? = nil
}

struct ChangePasswordRequest: Codable {
    var old_password: String? = nil
    var password: String? = nil
    var password_confirmation: String? = nil
}

struct GeocodingResponse: Codable {
    var place_id: Int? = nil
    var licence: String? = nil
    var osm_type: String? = nil
    var lat: String? = nil
    var lon: String? = nil
    var display_name: String? = nil
    var address: Address? = nil
}

struct Address: Codable {
    var city: String? = nil
    var town: String? = nil
    var county: String? = nil
    var state_district: String? = nil
    var state: String? = nil
    var country: String? = nil
    var country_code: String? = nil
}

struct AppSettings: Codable {
    var subscription: Bool? = nil
    var free_messages_count: Int? = nil
    var free_invitations_count: Int? = nil
}

struct AppSettingsResponse: Codable {
    var success: Bool
    var message: String? = nil
    var data: AppSettings? = nil
}

struct SubscriptionInfo: Codable {
    var id: Int? = nil
    var device: String? = nil
    var start_at: String? = nil
    var end_at: String? = nil
}

struct SubscribtionInfoResponse : Codable {
    var success: Bool
    var message: String? = nil
    var data: SubscriptionInfo? = nil
}
