//
//  PhotoEditorDataHolder.swift
//  BestDate
//
//  Created by Евгений on 16.06.2022.
//

import Foundation
import SwiftUI

class PhotoEditorDataHolder: ObservableObject {
    static let shared: PhotoEditorDataHolder = PhotoEditorDataHolder()
    
    @Published var selectedPhoto: UIImage = UIImage()
    @Published var offset: CGSize = CGSize.zero
    @Published var zoom: CGFloat = 1

    @Published var croppedPhoto: UIImage = UIImage()
    @Published var frame: CGFloat = UIScreen.main.bounds.width - 14

    func cropImage() {

        let sideLength = min(
            selectedPhoto.size.width,
            selectedPhoto.size.height
        ) / zoom

        let scale = sideLength / frame
        let maxXOffset = (selectedPhoto.size.width / scale) - frame
        let maxYOffset = (selectedPhoto.size.height / scale) - frame

        let xOffset = ((maxXOffset / 2) - offset.width) * scale
        let yOffset = ((maxYOffset / 2) - offset.height) * scale

        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength,
            height: sideLength
        ).integral

        let sourceCGImage = selectedPhoto.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!

        croppedPhoto = UIImage(
            cgImage: croppedCGImage,
            scale: selectedPhoto.imageRendererFormat.scale,
            orientation: selectedPhoto.imageOrientation
        )

    }
}
