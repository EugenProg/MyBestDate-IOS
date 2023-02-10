//
//  Font.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import SwiftUI

class MyFont {
    static func getFont(_ type: FontType, _ size: CGFloat) -> Font {
        .custom(type.name, size: size - 2)
    }
}

enum FontType {
    case BOLD
    case ITALIC
    case NORMAL

    var name: String {
        switch self {
        case .BOLD: return "notosansdisplay-bold"
        case .ITALIC: return "notosansdisplay-italic"
        case .NORMAL: return "notosansdisplay-regular"
        }
    }
}
