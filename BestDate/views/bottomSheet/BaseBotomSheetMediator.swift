//
//  BaseBotomSheetMediator.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import Foundation

class BaseButtonSheetMediator: ObservableObject {
    static let shared = BaseButtonSheetMediator()

    var closeAction: ((BottomSheetList) -> Void)? = nil
}
