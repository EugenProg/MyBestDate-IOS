//
//  RegistrationDataHolder.swift
//  BestDate
//
//  Created by Евгений on 12.06.2022.
//

import Foundation

final class RegistrationDataHolder: ObservableObject {
    static var shared: RegistrationDataHolder = RegistrationDataHolder()
    
    @Published var gender: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var birthDate: String = ""
    @Published var name: String = ""
}
