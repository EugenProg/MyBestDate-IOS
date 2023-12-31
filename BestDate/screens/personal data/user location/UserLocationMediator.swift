//
//  UserLocationMediator.swift
//  BestDate
//
//  Created by Евгений on 13.10.2022.
//

import Foundation

class UserLocationMediator: ObservableObject {
    static var shared = UserLocationMediator()

    func saveUserLocation(location: CityListItem, completion: @escaping (Bool) -> Void) {
        if location.city == UserDataHolder.shared.getUser().location?.city &&
            location.country == UserDataHolder.shared.getUser().location?.country {
            completion(true)
        } else {
            GeocodingApiService().getLocationByAddress(address: location) { response in
                CoreApiService.shared.saveUserLocation(location: response.getSaveLocationRequest()) { success, user in
                    DispatchQueue.main.async {
                        if success {
                            MainMediator.shared.setUserInfo()
                            ProfileMediator.shared.setUser(user: user)
                        }
                        completion(success)
                    }
                }
            }
        }
    }
}
