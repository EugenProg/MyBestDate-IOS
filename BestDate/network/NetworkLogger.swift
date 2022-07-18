//
//  NetworkLogger.swift
//  BestDate
//
//  Created by Евгений on 15.07.2022.
//

import Foundation

class NetworkLogger {

    static func printLog(response: URLResponse?) {
        print("\n\(String(describing: response?.http?.statusCode)) \(String(describing: response?.url))\n")
    }

    static func printLog(data: Data?) {
        print("jsonData: ", String(data: data!, encoding: .utf8) ?? "")
    }
}
