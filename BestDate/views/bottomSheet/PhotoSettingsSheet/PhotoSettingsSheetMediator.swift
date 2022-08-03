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
    var callPage: ScreenList = .PROFILE_PHOTO

    func deleteImage(id: Int, completion: @escaping (Bool) -> Void) {
        ImagesApiService.shared.deleteProfileImage(id: id) { success in
            if success {
                self.updateDataAction()
            }
            completion(success)
        }
    }

    func updateImageStatus(image: ProfileImage?, completion: @escaping (Bool) -> Void) {
        ImagesApiService.shared.updateImageStatus(id: image?.id ?? 0, requestData: PhotoStatusUpdateRequest(main: image?.main, top: image?.top)) { success in
            if success {
                self.updateDataAction()
            }
            completion(success)
        }
    }

    private func updateDataAction() {
        if callPage == .PROFILE_PHOTO {
            PhotoEditorMediator.shared.updateUserData()
        } else if callPage == .PROFILE {
            ProfileMediator.shared.updateUserData()
        }
    }
}
