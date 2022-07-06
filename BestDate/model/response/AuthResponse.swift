//
//  AuthResponse.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

struct AuthResponse: Decodable {
    var token_type: String
    var expires_in: Int
    var access_token: String
    var refresh_token: String
}
