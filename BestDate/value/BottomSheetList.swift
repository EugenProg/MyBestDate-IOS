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
    case NOT_CORRECT_PHOTO
    case QUESTIONNAIRE_SINGLE_SELECT
    case QUESTIONNAIRE_SEEK_BAR
    case QUESTIONNAIRE_SEARCH
    case QUESTIONNAIRE_MULTY_SELECT
    
    var heightMode: BottomSheetHeight {
        switch self {
        case .GENDER: return .AUTO
        case .PHOTO_SETTINGS: return .AUTO
        case .NOT_CORRECT_PHOTO: return .AUTO
        case .QUESTIONNAIRE_SINGLE_SELECT: return .AUTO
        case .QUESTIONNAIRE_SEEK_BAR: return .AUTO
        case .QUESTIONNAIRE_SEARCH: return .FULL
        case .QUESTIONNAIRE_MULTY_SELECT: return .AUTO
        }
    }
    
    var style: BottomSheetStyle {
        switch self {
        case .GENDER: return .BLACK
        case .PHOTO_SETTINGS: return .BLACK
        case .NOT_CORRECT_PHOTO: return .BLACK
        case .QUESTIONNAIRE_SINGLE_SELECT: return .WHITE
        case .QUESTIONNAIRE_SEEK_BAR: return .WHITE
        case .QUESTIONNAIRE_SEARCH: return .WHITE
        case .QUESTIONNAIRE_MULTY_SELECT: return .WHITE
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
