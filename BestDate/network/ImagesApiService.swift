//
//  ImagesApiService.swift
//  BestDate
//
//  Created by Евгений on 06.07.2022.
//

import Foundation
import UIKit

class ImagesApiService : NetworkRequest {
    static let shared = ImagesApiService()

    func saveProfileImage(image: UIImage, completion: @escaping (Bool, ProfileImage) -> Void) {
        var request = CoreApiTypes.saveImage.getRequest(withAuth: true)

        let media = Media(withImage: image, forKey: "photo")
        let boundary = NSUUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createDataBody(media: media, boundary: boundary)

        makeRequest(request: request, type: ProfileImageResponse.self) { response in
            completion(response?.success == true, response?.data ?? ProfileImage())
        }
    }

    func deleteProfileImage(id: Int, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.deleteImage.getRequest(withAuth: true)

        let body = IdListRequest(ids: [id])
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func updateImageStatus(id: Int, requestData: PhotoStatusUpdateRequest, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.updateImageStatus.getRequest(path: id.toString(), withAuth: true)

        makeRequest(request: request, body: requestData, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func sendImageMessage(image: UIImage, userId: Int, parentId: Int?, message: String?, completion: @escaping (Bool, Message) -> Void) {
        let path = parentId == nil ? userId.toString() : "\(userId)/\(parentId!)"
        var request = CoreApiTypes.sendMessage.getRequest(path: path, withAuth: true)

        let media = Media(withImage: image, forKey: "image")
        let boundary = NSUUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createDataBody(media: media, boundary: boundary)

        makeRequest(request: request, type: SendMessageResponse.self) { response in
            UserDataHolder.shared.setSentMessagesCount(count: response?.data?.sent_messages_today ?? 0)
            if message != nil {
                ChatApiService.shared.updateMessage(id: response?.data?.id ?? 0, message: message ?? "") { success, savedMessage in
                    completion(success, savedMessage)
                }
            } else {
                completion(response?.success == true, response?.data ?? Message())
            }
        }
    }

    func likeAImage(photoId: Int, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.likeAPhoto.getRequest(withAuth: true)

        let body = PhotoLikeRequest(photo_id: photoId)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }
}
