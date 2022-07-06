//
//  CitySearchMediator.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import Foundation
import GooglePlaces

class CitySearchMediator: ObservableObject {
    static var shared = CitySearchMediator()

//    private var token = GMSAutocompleteSessionToken.init()
//    var fetcher: GMSAutocompleteFetcher?

    @Published var cityList: [String] = []

//    init() {
//
//        let filter = GMSAutocompleteFilter()
//        filter.type = .city
//
//        fetcher = GMSAutocompleteFetcher(filter: filter)
//        //fetcher?.delegate = self
//        fetcher?.provide(token)
//    }
//
//    func search(text: String) {
//        fetcher?.sourceTextHasChanged(text)
//    }
}

//extension CitySearchMediator: GMSAutocompleteFetcherDelegate {
//    func isEqual(_ object: Any?) -> Bool {
//        false
//    }
//
//    var hash: Int {
//        <#code#>
//    }
//
//    var superclass: AnyClass? {
//        <#code#>
//    }
//
//    func `self`() -> Self {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func isProxy() -> Bool {
//        <#code#>
//    }
//
//    func isKind(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//
//    func isMember(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//
//    func conforms(to aProtocol: Protocol) -> Bool {
//        <#code#>
//    }
//
//    func responds(to aSelector: Selector!) -> Bool {
//        <#code#>
//    }
//
//    var description: String {
//        <#code#>
//    }
//
//  func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
//    let resultsStr = NSMutableString()
//    for prediction in predictions {
//      resultsStr.appendFormat("\n Primary text: %@\n", prediction.attributedPrimaryText)
//      resultsStr.appendFormat("Place ID: %@\n", prediction.placeID)
//    }
//
//      cityList.append(resultsStr as String)
//  }
//
//  func didFailAutocompleteWithError(_ error: Error) {
//      cityList.append(error.localizedDescription)
//  }
//}
