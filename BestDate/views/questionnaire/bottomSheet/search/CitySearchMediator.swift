//
//  CitySearchMediator.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import Foundation

class CitySearchMediator: ObservableObject {
    static var shared = CitySearchMediator()

    @Published var cityList: [String] = []
}
