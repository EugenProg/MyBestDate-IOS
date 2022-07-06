//
//  StringUtils.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

class StringUtils {
    static func isPhoneNumber(phone: String?) -> Bool {
        if phone == nil || phone?.isEmpty == true {
            return false
        }

        var line = phone ?? ""
        line.removeAll(where: { c in c == "+" })

        if NumberFormatter().number(from: line) != nil {
            return line.count > 10 && line.count < 14
        } else {
            return false
        }
    }

    static func isAEmail(email: String?) -> Bool {
        if email == nil || email?.isEmpty == true {
            return false
        }

        let regex = try? NSRegularExpression(pattern: "\\S+@\\S+\\.[a-zA-Z]{2,3}") //\S+@\S+\.[a-zA-Z]{2,3}
        let range = NSRange(location: 0, length: email?.utf16.count ?? 0)
        return regex?.firstMatch(in: email ?? "", range: range) != nil
    }
}
