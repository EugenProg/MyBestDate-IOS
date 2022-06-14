//
//  Media.swift
//  BestDate
//
//  Created by Евгений on 15.06.2022.
//

import Foundation
import UIKit

struct Media {
    let key: String
    let filename: String
    var data: Data
    let mimeType: String

    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        mimeType = "image/jpeg"
        filename = "file"

        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        self.data = data
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
