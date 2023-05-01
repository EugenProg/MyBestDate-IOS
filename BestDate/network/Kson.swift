//
//  Kson.swift
//  BestDate
//
//  Created by Евгений on 01.05.2023.
//

import Foundation

class Kson {
    static var shared: Kson = Kson()

    func fromJson<T: Codable>(json: String, type: T.Type) -> T? {
        fromJson(json: Data(json.utf8), type: type)
    }

    func fromJson<T: Codable>(json: Data, type: T.Type) -> T? {
        try? JSONDecoder().decode(type, from: json)
    }

    func toJsonData<T: Codable>(value: T) -> Data? {
        return try? self.getEncoder().encode(value)
    }

    func toJson<T: Codable>(value: T) -> String? {
        let jsonData = toJsonData(value: value)
        return String(data: jsonData!, encoding: String.Encoding.utf8)
    }

    private func getEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        return encoder
    }
}
