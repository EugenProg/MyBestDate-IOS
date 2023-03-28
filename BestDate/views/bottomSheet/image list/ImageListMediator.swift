//
//  ImageListMediator.swift
//  BestDate
//
//  Created by Евгений on 06.11.2022.
//

import Foundation
import UIKit

class ImageListMediator: ObservableObject {
    static var shared = ImageListMediator()

    @Published var imageList: [ImageItem] = []
    var savedPosition: CGFloat = 0
    var fetcher: ImageFetcher? = nil
    var noPermissionAction: (() -> Void)? = nil
    private var hasPermission: Bool = false
    private let itemHeight: CGFloat = ((UIScreen.main.bounds.width) / 3)

    var imageIsSelect: ((UIImage) -> Void)? = nil

    init() {
        fetcher = ImageFetcher()
    }

    func initFetcher() {
        fetcher?.addImages = { images in
            DispatchQueue.main.async {
                self.imageList.removeAll()
                self.imageList = images
            }
        }
        fetcher?.addImage = { image in
            DispatchQueue.main.async {
                self.imageList.removeAll { oldImage in oldImage.id == image.id }
                self.imageList.append(image)
            }
        }

        fetcher?.getPermission(completion: { hasPermission in
            self.hasPermission = hasPermission
            if hasPermission {
                self.getImages()
            } else {
                if self.noPermissionAction != nil {
                    self.noPermissionAction!()
                }
            }
        })

        fetcher?.noImages = {
            if self.noPermissionAction != nil {
                self.noPermissionAction!()
            }
        }
    }

    func getImages() {
        if hasPermission {
            if savedPosition == 0 {
                fetcher?.getImageListAsync()
            } else {
                fetcher?.getImageList()
            }
        } else {
            initFetcher()
        }
    }

    func savePosition(_ offset: CGFloat) {
        savedPosition = -(((offset / itemHeight) * 3) + 3)
    }
}
