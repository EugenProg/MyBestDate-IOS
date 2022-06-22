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
}
