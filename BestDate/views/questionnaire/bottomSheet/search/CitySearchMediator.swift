//
//  CitySearchMediator.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import Foundation
import GooglePlaces
import Combine

class CitySearchMediator: NSObject, ObservableObject {
    static var shared = CitySearchMediator()

    private var token = GMSAutocompleteSessionToken.init()
    var fetcher: GMSAutocompleteFetcher?
    var isInited = false

    @Published var cityList: [String] = []
    @Published var searchText: String = ""

    private var cancellableSet: Set<AnyCancellable> = []

    override init() {

        GMSPlacesClient.provideAPIKey("AIzaSyCAvbkXsVq1FQuiLdwbwJxiM6WoYfYSX8I")

        let filter = GMSAutocompleteFilter()
        filter.accessibilityLanguage = "en"
        filter.type = .city

        fetcher = GMSAutocompleteFetcher(filter: filter)
        fetcher?.accessibilityLanguage = "en"
        fetcher?.provide(token)
    }

    func initSearch() {
        print(">>> init search")
        fetcher?.delegate = self
        
        $searchText
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if (string.count < 1) {
                    self.cityList = []
                    return nil
                }
                return string
            })
            .compactMap { $0 }
            .sink { (_) in
            } receiveValue: { [self] in
                search(text: searchText)
            }
            .store(in: &cancellableSet)

        isInited = true
    }

    func search(text: String) {
        if !isInited { initSearch() }
        print(">>> action \(text)")
        fetcher?.sourceTextHasChanged(text)
    }
}

extension CitySearchMediator: GMSAutocompleteFetcherDelegate {

  func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
      print(">>> search results \(predictions.count)")
      cityList.removeAll()
    for prediction in predictions {
        let city = prediction.attributedPrimaryText.string
        let countryLine = prediction.attributedSecondaryText?.string
        var country = ""
        if (countryLine?.contains(",") ?? false) {
            country = countryLine?.components(separatedBy: ", ").last ?? ""
        } else { country = countryLine ?? "" }
        let result = city + ", " + country
        if !cityList.contains(result) { cityList.append(result) }
    }
  }

  func didFailAutocompleteWithError(_ error: Error) {
      print(">>> error \(error)")
      cityList.append(error.localizedDescription)
  }
}
