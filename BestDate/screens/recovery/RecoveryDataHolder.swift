//
//  RecoveryDataHolder.swift
//  BestDate
//
//  Created by Евгений on 13.06.2022.
//

import Foundation

class RecoveryDataHolder: ObservableObject {
    static var shared: RecoveryDataHolder = RecoveryDataHolder()
    
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var newPass: String = ""
}
