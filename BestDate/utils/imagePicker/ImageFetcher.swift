//
//  ImageFetcher.swift
//  BestDate
//
//  Created by Евгений on 06.11.2022.
//

import Foundation
import Photos
import UIKit

class ImageFetcher {
    var size: CGSize = CGSize(width: 800, height: 800)
    var addImages: (([ImageItem]) -> Void)? = nil
    var addImage: ((ImageItem) -> Void)? = nil
    var noImages: (() -> Void)? = nil
    var permissionStatus: PHAuthorizationStatus = .denied

    func getPermission(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            self.permissionStatus = status
            completion(status == .authorized || status == .limited)
        }
    }

    private func getAssets() -> PHFetchResult<PHAsset> {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary
        fetchOptions

        return PHAsset.fetchAssets(with: fetchOptions)
    }

    private func getImagesFromAssets(assets: PHFetchResult<PHAsset>) {
        var id: Int = 0
        var images: [ImageItem] = []

        assets.enumerateObjects({ (object, count, stop) in
            if object.mediaType == .image {
                let size = CGSize(width: object.pixelWidth, height: object.pixelHeight)
                PHImageManager.default().requestImage(for: object, targetSize: size, contentMode: .aspectFill, options: self.imageRequestOptions) { image, info in
                    images.append(ImageItem(id: id, image: image ?? UIImage()))
                    id += 1
                }
            }
        })

        if images.isEmpty && self.noImages != nil {
            self.noImages!()
        }

        if self.addImages != nil {
            self.addImages!(images)
        }
    }

    private func getImagesFromAssetsAsync(assets: PHFetchResult<PHAsset>) {
        var id: Int = 0

        assets.enumerateObjects({ (object, count, stop) in
            if object.mediaType == .image {
                PHImageManager.default().requestImage(for: object, targetSize: self.size, contentMode: .aspectFill, options: self.imageRequestOptions) { image, info in
                    if self.addImage != nil {
                        self.addImage!(ImageItem(id: id, image: image ?? UIImage()))
                    }
                    id += 1
                }
            }
        })

        if id == 0 && self.noImages != nil {
            self.noImages!()
        }
    }

    func getImageList() {
        DispatchQueue.global().async {
            self.getImagesFromAssets(assets: self.getAssets())
        }
    }

    func getImageListAsync() {
        DispatchQueue.global().async {
            self.getImagesFromAssetsAsync(assets: self.getAssets())
        }
    }

    var imageRequestOptions: PHImageRequestOptions {
            let options = PHImageRequestOptions()
            options.version = .current
            options.resizeMode = .exact
            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true
            options.isSynchronous = true
            return options
        }
}

struct ImageItem {
    var id: Int
    var image: UIImage
}
