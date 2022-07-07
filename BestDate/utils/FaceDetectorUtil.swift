//
//  FaceDetector.swift
//  BestDate
//
//  Created by Евгений on 06.07.2022.
//

import Foundation
import MLKitFaceDetection
import MLKit
import UIKit

class FaceDetectorUtil {

    var faceDetector: FaceDetector? = nil

    init() {
        faceDetector = FaceDetector.faceDetector()
    }

    func detectFaces(image: UIImage, completion: @escaping (Bool, Int) -> Void) {
        let visionImage = VisionImage(image: image)

        faceDetector?.process(visionImage) { faces, error in
            if error == nil {
                print(">>> Detection successful, found \(faces?.count ?? 0) faces")
                completion(true, faces?.count ?? 0)
            } else {
                print(">>> Detection error: \(error.debugDescription)")
                completion(false, 0)
            }
        }
    }
}
