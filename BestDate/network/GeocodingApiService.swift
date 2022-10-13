//
//  GeocodingApiService.swift
//  BestDate
//
//  Created by Евгений on 12.10.2022.
//

import Foundation

class GeocodingApiService {

    func getLocationByAddress(address: CityListItem, completion: @escaping (GeocodingResponse) -> Void) {
        let request = getRequest(address: address)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            NetworkLogger.printLog(data: data)
            if let data = data, let response = try? JSONDecoder().decode([GeocodingResponse].self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.first ?? GeocodingResponse())
            } else {
                completion(GeocodingResponse())
            }
        }

        task.resume()
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
