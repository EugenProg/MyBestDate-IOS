//
//  DeeplinkCreator.swift
//  BestDate
//
//  Created by Евгений on 19.02.2023.
//

import Foundation
import FirebaseDynamicLinks

class DeeplinkCreator {
    func get(userId: Int?, userName: String) -> String {
        guard let link = URL(string: "https://best-date.com/\(userId ?? 0)") else { return "" }
        let dynamicLinksDomainURIPrefix = "https://mybestdate.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)

        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.bestDate")
        linkBuilder?.iOSParameters?.appStoreID = "1635182272"

        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.bestDate")

        linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder?.socialMetaTagParameters?.title = "Link to \(userName)'s profile in My Best Date"
        linkBuilder?.socialMetaTagParameters?.descriptionText = "This link opens the user profile in My Best Date application"
        linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: "\(CoreApiTypes.serverAddress)/images/ic_launcher-playstore.png")

        guard let longDynamicLink = linkBuilder?.url else { return "" }
        return longDynamicLink.absoluteString
    }
}
