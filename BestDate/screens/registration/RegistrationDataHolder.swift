//
//  RegistrationDataHolder.swift
//  BestDate
//
//  Created by Евгений on 12.06.2022.
//

import Foundation
import UIKit

final class RegistrationDataHolder: ObservableObject {
    static var shared: RegistrationDataHolder = RegistrationDataHolder()
    
    @Published var gender: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var birthDate: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var imageList: [UIImage] = []
    
    @Published var selectedImage: UIImage = UIImage()
}
