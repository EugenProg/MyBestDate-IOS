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
