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
