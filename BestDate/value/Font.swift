//
//  Font.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import SwiftUI

class MyFont {
    static func getFont(_ type: FontType, _ size: CGFloat) -> Font {
        .custom(type.name, size: size)
    }
}

enum FontType {
    case BOLD
    case ITALIC
    case NORMAL

    var name: String {
        switch self {
        case .BOLD: return "cronospro-bold"
        case .ITALIC: return "cronospro-italic"
        case .NORMAL: return "cronospro-regular"
        }
    }
}
