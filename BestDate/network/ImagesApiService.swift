//
//  ImagesApiService.swift
//  BestDate
//
//  Created by Евгений on 06.07.2022.
//

import Foundation
import UIKit

class ImagesApiService {
    static let shared = ImagesApiService()
    private let encoder = JSONEncoder()

    func saveProfileImage(image: UIImage, completion: @escaping (Bool, ProfileImage) -> Void) {
        var request = CoreApiTypes.saveImage.getRequest(withAuth: true)

        let media = Media(withImage: image, forKey: "photo")
        let boundary = NSUUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createDataBody(media: media, boundary: boundary)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(ProfileImageResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(true, response.data ?? ProfileImage())
            } else {
                completion(false, ProfileImage())
            }
        }

        task.resume()
    }

    func deleteProfileImage(id: Int, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.deleteImage.getRequest(withAuth: true)

        let data = try! encoder.encode(IdListRequest(ids: [id]))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func updateImageStatus(id: Int, requestData: PhotoStatusUpdateRequest, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.updateImageStatus.getRequest(path: id.toString(), withAuth: true)

        let data = try! encoder.encode(requestData)
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func sendImageMessage(image: UIImage, userId: Int, parentId: Int?, message: String?, completion: @escaping (Bool, Message) -> Void) {
        let path = parentId == nil ? userId.toString() : "\(userId)/\(parentId!)"
        var request = CoreApiTypes.sendMessage.getRequest(path: path, withAuth: true)

        let media = Media(withImage: image, forKey: "image")
        let boundary = NSUUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createDataBody(media: media, boundary: boundary)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(SendMessageResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                if message != nil {
                    ChatApiService.shared.updateMessage(id: response.data?.id ?? 0, message: message ?? "") { success, savedMessage in
                        completion(success, savedMessage)
                    }
                } else {
                    completion(response.success, response.data ?? Message())
                }
            } else {
                completion(false, Message())
            }
        }

        task.resume()
    }

    func likeAImage(photoId: Int, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.likeAPhoto.getRequest(withAuth: true)

        let data = try! encoder.encode(PhotoLikeRequest(photo_id: photoId))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    private func createDataBody (media: Media?, boundary: String) -> Data {
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
}
