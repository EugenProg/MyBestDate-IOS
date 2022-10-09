//
//  AuthResponse.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

struct AuthResponse: Decodable {
    var token_type: String? = nil
    var expires_in: Int? = nil
    var access_token: String? = nil
    var refresh_token: String? = nil
    var registration: Bool? = nil
    var error: String? = nil
    var error_description: String? = nil
    var message: String? = nil
}
