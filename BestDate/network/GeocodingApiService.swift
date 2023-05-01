//
//  GeocodingApiService.swift
//  BestDate
//
//  Created by Евгений on 12.10.2022.
//

import Foundation

class GeocodingApiService: NetworkRequest {

    func getLocationByAddress(address: CityListItem, completion: @escaping (GeocodingResponse) -> Void) {
        let request = getRequest(address: address)

        makeRequest(request: request, type: [GeocodingResponse].self) { response in
            completion(response?.first ?? GeocodingResponse())
        }
    }

    private func getRequest(address: CityListItem) -> URLRequest {
        let query = "?format=json&addressdetails=1&city=\(address.city)&country=\(address.country ?? "")"
        let escapedText = String(describing: query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? query)
        let url = URL(string: "https://nominatim.openstreetmap.org/search\(escapedText)")
        var request = URLRequest(url: url!)
        request.setValue("en", forHTTPHeaderField: "Accept-Language")
        request.httpMethod = "GET"

        print("\n\("GET") https://nominatim.openstreetmap.org/search\(query)\n")
        return request
    }
}
