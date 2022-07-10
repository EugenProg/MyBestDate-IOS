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
    var simpaty: Bool? = nil
}

struct UserDataResponse: Codable {
    var success: Bool
    var message: String
    var data: UserInfo? = nil
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
    var new_likes: Int? = nil
    var new_guests: Int? = nil
    var photos: [ProfileImage]? = nil
    //var location: String? = nil
    var questionnaire: Questionnaire? = nil
}

struct Questionnaire: Codable {
    var purpose: String? = nil
    var height: String? = nil
    var weight: String? = nil
    var eye_color: String? = nil
    var hair_color: String? = nil
    var hair_length: String? = nil
    var marital_status: String? = nil
    var kids: String? = nil
    var education: String? = nil
    var occupation: String? = nil
    var about_me: String? = nil
    var search_age_min: Int? = nil
    var search_age_max: Int? = nil
    var socials: [String]? = []
    var hobby: [String]? = []
    var sport: [String]? = []
    var evening_time: String? = nil
}


struct UserListResponse: Codable {
    var success: Bool
    var message: String
    var data: [UserInfo] = []
}
