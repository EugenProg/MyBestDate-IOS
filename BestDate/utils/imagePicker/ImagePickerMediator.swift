//
//  ImagePickerMediator.swift
//  BestDate
//
//  Created by Евгений on 02.04.2023.
//

import Foundation

class ImagePickerMediator: ObservableObject {
    static var shared = ImagePickerMediator()

    @Published var isShowingPhotoLibrary: Bool = false
}
