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

    func printLog(response: URLResponse?) {
        print("\n------------------------------------------------------------------")
        print("\(response?.http?.statusCode ?? 0) \(response?.url?.absoluteString ?? "") \(response?.http?.isSuccessful == true ? "✅" : "🚫")\n")
    }

    func printLog(request: URLRequest) {
        print("\n------------------------------------------------------------------")
        print("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")\n")
        print("headers: ")
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            print("\(key): \(value)")
        }
        if request.httpBody != nil {
            print("body: \(String(data: request.httpBody!, encoding: .utf8) ?? "")")
        }
        print("------------------------------------------------------------------\n")
    }

    func printLog(data: Data?) {
        print("jsonData: ", String(data: data!, encoding: .utf8) ?? "")
        print("------------------------------------------------------------------\n")
    }
}

class NetworkRequest : NetworkLogger {
    var currentTask: URLSessionDataTask? = nil

    func makeRequest<BT: Codable, RT: Codable>(request: URLRequest, body: BT, type: RT.Type, completion: @escaping (RT?) -> Void) {

        var request = request
        let data = Kson.shared.toJsonData(value: body)
        request.httpBody = data

        _ = resumeTask(request: request, type: type) { response in
            completion(response)
        }
    }

    func makeRequest<RT: Codable>(request: URLRequest, type: RT.Type, completion: @escaping (RT?) -> Void) {
        _ = resumeTask(request: request, type: type) { response in
            completion(response)
        }
    }

    func makeTaskRequest<BT: Codable, RT: Codable>(request: URLRequest, body: BT, type: RT.Type, completion: @escaping (RT?) -> Void) -> URLSessionDataTask {

        var request = request
        let data = Kson.shared.toJsonData(value: body)
        request.httpBody = data

        let task = resumeTask(request: request, type: type) { response in
            completion(response)
        }
        return task
    }

    func makeTaskRequest<RT: Codable>(request: URLRequest, type: RT.Type, completion: @escaping (RT?) -> Void) -> URLSessionDataTask {
        let task = resumeTask(request: request, type: type) { response in
            completion(response)
        }
        return task
    }

    func createDataBody(media: Media?, boundary: String) -> Data {
        var body = Data()
        if let media = media {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(media.key)\"; filename=\"\(media.filename)\"\r\n")
                body.append("Content-Type: \(media.mimeType)\r\n\r\n".data(using: .utf8)!)
                body.append(media.data)
        }
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }

    private func resumeTask<RT: Codable>(request: URLRequest, type: RT.Type, completion: @escaping (RT?) -> Void) -> URLSessionDataTask {
        printLog(request: request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.printLog(response: response)
            if response?.http?.isUnAuth == true {
                CoreApiService.shared.refreshToken { success in
                    if success {
                        _ = self.resumeTask(request: request.refreshToken(), type: type) { response in
                            completion(response)
                        }
                    } else {
                        completion(nil)
                    }
                }
            } else {
                if let data = data, let response = Kson.shared.fromJson(json: data, type: type) {
                    self.printLog(data: data)
                    completion(response)
                } else {
                    completion(nil)
                }
            }
        }

        task.resume()
        return task
    }

    func cancelCurrentTask() {
        if currentTask != nil {
            currentTask?.cancel()
            currentTask = nil
        }
    }
}
