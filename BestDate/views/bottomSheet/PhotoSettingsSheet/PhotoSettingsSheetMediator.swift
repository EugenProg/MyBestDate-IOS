//
//  PhotoSettingsSheetMediator.swift
//  BestDate
//
//  Created by Евгений on 25.07.2022.
//

import Foundation

class PhotoSettingsSheetMediator: ObservableObject {
    static var shared = PhotoSettingsSheetMediator()

    @Published var selectedPhoto: ProfileImage? = nil

    var deleteAction: ((Int) -> Void)? = nil
    var updateAction: ((ProfileImage?) -> Void)? = nil

    func deleteImage(id: Int, completion: @escaping (Bool) -> Void) {
        ImagesApiService.shared.deleteProfileImage(id: id) { success in
            if success && self.deleteAction != nil {
                self.deleteAction!(id)
            }
            completion(success)
        }
    }

    func updateImageStatus(image: ProfileImage?, completion: @escaping (Bool) -> Void) {
        ImagesApiService.shared.updateImageStatus(id: image?.id ?? 0, requestData: PhotoStatusUpdateRequest(main: image?.main, top: image?.top, match: image?.match)) { success in
            if success && self.updateAction != nil {
                self.updateAction!(image)
            }
            completion(success)
        }
    }
}