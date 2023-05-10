//
//  SubscriptionApiService.swift
//  BestDate
//
//  Created by Евгений on 07.05.2023.
//

import Foundation

class SubscriptionApiService: NetworkRequest {
    static var shared = SubscriptionApiService()

    func getAppSettings() {
        let request = CoreApiTypes.getAppSettings.getRequest()

        makeRequest(request: request, type: AppSettingsResponse.self) { response in
            UserDataHolder.shared.setAppSettings(appSettings: response?.data)
        }
    }

    func updateSubscriptionInfo(startDate: String, endDate: String) {
        let request = CoreApiTypes.updateSubscriptionInfo.getRequest(withAuth: true)

        let body = UpdateSubscriptionInfoRequest(start_at: startDate, end_at: endDate)
        makeRequest(request: request, body: body, type: BaseResponse.self) { _ in
            
        }
    }

    func getUserSubscriptionInfo() {
        let request = CoreApiTypes.getUserSubscriptionInfo.getRequest(withAuth: true)

        let body = UpdateSubscriptionInfoRequest()
        makeRequest(request: request, body: body, type: SubscribtionInfoResponse.self) { response in

        }
    }
}
