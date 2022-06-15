//
//  BottomSheetList.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import Foundation
import SwiftUI

enum BottomSheetList: String {
    case GENDER
    case PHOTO_SETTINGS
    
    var heightMode: BottomSheetHeight {
        switch self {
        case .GENDER: return .AUTO
        case .PHOTO_SETTINGS: return .AUTO
        }
    }
    
    var style: BottomSheetStyle {
        switch self {
        case .GENDER: return .BLACK
        case .PHOTO_SETTINGS: return .BLACK
        }
    }
}

enum BottomSheetStyle: String {
    case WHITE
    case BLACK
    
    var backColor: Color {
        switch self {
        case .WHITE: return ColorList.white.color
        case .BLACK: return ColorList.main.color
        }
    }
}
