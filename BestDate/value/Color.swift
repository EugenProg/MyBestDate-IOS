//
//  Color.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import SwiftUI

class MyColor {

    static func getColor(_ red: Double, _ green: Double, _ blue: Double) -> Color {
        Color(red: red / 255, green: green / 255, blue: blue / 255)
    }

    static func getColor(_ red: Double, _ green: Double, _ blue: Double, _ opacity: Double) -> Color {
        Color(red: red / 255, green: green / 255, blue: blue / 255, opacity: opacity)
    }
    
    static func getColor(_ red: Double, _ green: Double, _ blue: Double) -> UIColor {
        UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }

    static func getColor(_ red: Double, _ green: Double, _ blue: Double, _ opacity: Double) -> UIColor {
        UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: opacity)
    }
}

enum ColorList {
    case transparent
    
    case main
    case main_5
    case main_10
    case main_20
    case main_30
    case main_50
    case main_60
    case main_70
    case main_90

    case white
    case white_5
    case white_10
    case white_13
    case white_60
    case white_70
    case white_80
    case white_90
    
    case pink
    case pink_18
    
    case light_blue
    
    case blue
    case blue_90
    
    case gray
    case red
    
    var color: Color {
        switch self {
        case .transparent: return MyColor.getColor(0, 0, 0, 0)
            
        case .main: return MyColor.getColor(40, 48, 52)
        case .main_5: return MyColor.getColor(40, 48, 52, 0.05)
        case .main_10: return MyColor.getColor(40, 48, 52, 0.1)
        case .main_20: return MyColor.getColor(40, 48, 52, 0.2)
        case .main_30: return MyColor.getColor(40, 48, 52, 0.3)
        case .main_50: return MyColor.getColor(40, 48, 52, 0.5)
        case .main_60: return MyColor.getColor(40, 48, 52, 0.6)
        case .main_70: return MyColor.getColor(40, 48, 52, 0.7)
        case .main_90: return MyColor.getColor(40, 48, 52, 0.9)
            
        case .white: return MyColor.getColor(255, 255, 255)
        case .white_5: return MyColor.getColor(255, 255, 255, 0.05)
        case .white_10: return MyColor.getColor(255, 255, 255, 0.1)
        case .white_13: return MyColor.getColor(255, 255, 255, 0.13)
        case .white_60: return MyColor.getColor(255, 255, 255, 0.6)
        case .white_70: return MyColor.getColor(255, 255, 255, 0.7)
        case .white_80: return MyColor.getColor(255, 255, 255, 0.8)
        case .white_90: return MyColor.getColor(255, 255, 255, 0.9)
            
        case .pink: return MyColor.getColor(242, 138, 229)
        case .pink_18: return MyColor.getColor(242, 138, 229, 0.18)
        case .light_blue: return MyColor.getColor(190, 239, 255)
        case .blue: return MyColor.getColor(123, 215, 245)
        case .blue_90: return MyColor.getColor(230, 123, 215, 0.9)
        case .gray: return MyColor.getColor(31, 231, 238, 0.95)
        case .red: return MyColor.getColor(255, 51, 51)
        }
    }
    
    var uiColor: UIColor {
        switch self {
        case .transparent: return MyColor.getColor(0, 0, 0, 0)
            
        case .main: return MyColor.getColor(40, 48, 52)
        case .main_5: return MyColor.getColor(40, 48, 52, 0.05)
        case .main_10: return MyColor.getColor(40, 48, 52, 0.1)
        case .main_20: return MyColor.getColor(40, 48, 52, 0.2)
        case .main_30: return MyColor.getColor(40, 48, 52, 0.3)
        case .main_50: return MyColor.getColor(40, 48, 52, 0.5)
        case .main_60: return MyColor.getColor(40, 48, 52, 0.6)
        case .main_70: return MyColor.getColor(40, 48, 52, 0.7)
        case .main_90: return MyColor.getColor(40, 48, 52, 0.9)
            
        case .white: return MyColor.getColor(255, 255, 255)
        case .white_5: return MyColor.getColor(255, 255, 255, 0.05)
        case .white_10: return MyColor.getColor(255, 255, 255, 0.1)
        case .white_13: return MyColor.getColor(255, 255, 255, 0.13)
        case .white_60: return MyColor.getColor(255, 255, 255, 0.6)
        case .white_70: return MyColor.getColor(255, 255, 255, 0.7)
        case .white_80: return MyColor.getColor(255, 255, 255, 0.8)
        case .white_90: return MyColor.getColor(255, 255, 255, 0.9)
            
        case .pink: return MyColor.getColor(242, 138, 229)
        case .pink_18: return MyColor.getColor(242, 138, 229, 0.18)
        case .light_blue: return MyColor.getColor(190, 239, 255)
        case .blue: return MyColor.getColor(123, 215, 245)
        case .blue_90: return MyColor.getColor(230, 123, 215, 0.9)
        case .gray: return MyColor.getColor(31, 231, 238, 0.95)
        case .red: return MyColor.getColor(255, 51, 51)
        }
    }
}
