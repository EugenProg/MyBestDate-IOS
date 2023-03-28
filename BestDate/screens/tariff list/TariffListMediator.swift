//
//  TariffListMediator.swift
//  BestDate
//
//  Created by Евгений on 04.03.2023.
//

import Foundation
import SwiftUI

class TariffListMediator: ObservableObject {
    static let shared = TariffListMediator()

    @Published var tariffsList: [TariffType] = [.montly, .three_months, .six_months]
}

enum TariffType {
    case montly
    case three_months
    case six_months

    var id: Int {
        switch self {
        case .montly: return 0
        case .three_months: return 1
        case .six_months: return 2
        }
    }

    var title: String {
        switch self {
        case .montly: return "montly_plan"
        case .three_months: return "three_months_plan"
        case .six_months: return "six_months_plan"
        }
    }

    var popular: Bool {
        switch self {
        case .montly: return true
        case .three_months: return false
        case .six_months: return false
        }
    }

    var amount: Double {
        switch self {
        case .montly: return 5.99
        case .three_months: return 14.99
        case .six_months: return 26.99
        }
    }

    var period: String {
        switch self {
        case .montly: return "per_montly"
        case .three_months: return "per_three_monthly"
        case .six_months: return "per_six_monthly"
        }
    }

    var color: Color {
        switch self {
        case .montly: return ColorList.light_blue.color
        case .three_months: return ColorList.pink.color
        case .six_months: return ColorList.white.color
        }
    }

    var switchImage: String {
        switch self {
        case .montly: return "ic_tariff_switch_blue"
        case .three_months: return "ic_tariff_switch_pink"
        case .six_months: return "ic_tariff_switch_white"
        }
    }

    var buttonStyle: StandardButton.StandardButtonStyle {
        switch self {
        case .montly: return .blue
        case .three_months: return .pink
        case .six_months: return .white
        }
    }
}
