//
//  PhotoEditorDataHolder.swift
//  BestDate
//
//  Created by Евгений on 16.06.2022.
//

import Foundation
import SwiftUI

class PhotoEditorMediator: ObservableObject {
    static let shared: PhotoEditorMediator = PhotoEditorMediator()
    
    @Published var newPhoto: UIImage = UIImage()
    @Published var offset: CGSize = CGSize.zero
    @Published var zoom: CGFloat = 1

    @Published var croppedPhoto: UIImage = UIImage()
    @Published var frame: CGFloat = UIScreen.main.bounds.width - 14
    @Published var imageList: [ProfileImage] = []

    @Published var mainPhoto: ProfileImage? = nil

    var saveAction: ((ProfileImage) -> Void)? = nil

    func saveImage(image: UIImage, completion: @escaping (Bool) -> Void) {
        ImagesApiService.shared.saveProfileImage(image: image) { success, profileImage in
            DispatchQueue.main.async {
                if success {
                    self.imageList.append(profileImage)
                    if self.saveAction != nil {
                        self.saveAction!(profileImage)
                    }
                    PhotoSettingsSheetMediator.shared.selectedPhoto = profileImage
                    if (profileImage.main ?? false) || self.imageList.count == 1 {
                        self.mainPhoto = profileImage
                    }
                }
                completion(success)
            }
        }
    }

    private func setUser(user: UserInfo) {
        withAnimation {
            self.mainPhoto = user.getMainPhoto()
            self.imageList.clearAndAddAll(list: user.photos)
        }
    }

    func updateUserData() {
        CoreApiService.shared.getUserData { success, user in
            if success {
                DispatchQueue.main.async {
                    MainMediator.shared.setUserInfo(user: user)
                    self.setUser(user: user)
                }
            }
        }
    }

    func setImages(images: [ProfileImage]) {
        self.imageList.removeAll()
        for image in images {
            if image.main ?? false { self.mainPhoto = image }
            self.imageList.append(image)
        }
        if self.mainPhoto == nil && !images.isEmpty { self.mainPhoto = images.first }
    }

    func cropImage() {

        let sideLength = min(
            newPhoto.size.width,
            newPhoto.size.height
        ) / zoom

        let scale = sideLength / frame
        let maxXOffset = (newPhoto.size.width / scale) - frame
        let maxYOffset = (newPhoto.size.height / scale) - frame

        let xOffset = ((maxXOffset / 2) - offset.width) * scale
        let yOffset = ((maxYOffset / 2) - offset.height) * scale

        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength,
            height: sideLength
        ).integral

        let sourceCGImage = newPhoto.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!

        croppedPhoto = UIImage(
            cgImage: croppedCGImage,
            scale: newPhoto.imageRendererFormat.scale,
            orientation: newPhoto.imageOrientation
        )

    }

    func searchFaces(completion: @escaping (Bool) -> Void) {
        let detector = FaceDetectorUtil()
        detector.detectFaces(image: croppedPhoto) { success, facesCount in
            if success { completion(facesCount == 1) }
            else { completion(success) }
        }
    }
}
