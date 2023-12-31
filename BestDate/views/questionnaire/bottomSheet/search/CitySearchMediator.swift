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

    @Published var cityList: [CityListItem] = []
    @Published var searchText: String = ""

    private var cancellableSet: Set<AnyCancellable> = []

    override init() {

        GMSPlacesClient.provideAPIKey("AIzaSyCAvbkXsVq1FQuiLdwbwJxiM6WoYfYSX8I")

        let filter = GMSAutocompleteFilter()
        filter.accessibilityLanguage = "lang_code".localized()
        filter.type = .city

        fetcher = GMSAutocompleteFetcher(filter: filter)
        fetcher?.accessibilityLanguage = "lang_code".localized()
        fetcher?.provide(token)
    }

    func initSearch() {
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
        fetcher?.sourceTextHasChanged(text)
    }
}

extension CitySearchMediator: GMSAutocompleteFetcherDelegate {

    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        cityList.removeAll()
        for prediction in predictions {
            let city = prediction.attributedPrimaryText.string
            let country = getItemFromLine(line: prediction.attributedSecondaryText?.string)
            let result = CityListItem(id: cityList.count, country: country,city: city)
            if !cityList.contains(where: { item in item.city == result.city && item.country == result.country }) && result.getCityLine() != searchText {
                cityList.append(result)
            }

        }
    }

    private func getItemFromLine(line: String?) -> String {
        var item = ""
        if (line?.contains(",") == true) {
            item = line?.components(separatedBy: ", ").last ?? ""
        } else { item = line ?? "" }
        return item
    }

    func didFailAutocompleteWithError(_ error: Error) {
        print(">>> error \(error)")
    }
}

struct CityListItem {
    var id: Int
    var country: String? = nil
    var city: String

    func getCityLine() -> String {
        city + ", " + (country ?? "")
    }
}
