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
    private let itemHeight: CGFloat = ((UIScreen.main.bounds.width - 12) / 3)

    var imageIsSelect: ((UIImage) -> Void)? = nil

    func getImages() {
        DispatchQueue.global().async {
            let images = ImageFetcher().getImageList()
            DispatchQueue.main.async {
                self.imageList = images
            }
        }
    }

    func savePosition(_ offset: CGFloat) {
        savedPosition = -((offset / itemHeight) * 3)
    }
}
