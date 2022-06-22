//
//  ImageExtension.swift
//  BestDate
//
//  Created by Евгений on 16.06.2022.
//

import Foundation
import SwiftUI

extension Image {
    func scaleAndMove() -> some View {
        
        //GeometryReader { geo in
        return self
                .resizable()
                .aspectRatio(contentMode: .fill)
                //.frame(width: geo.size.width * 0.8)
               // .frame(width: geo.size.width, height: geo.size.height)
                //.offset(x: xOffset, y: yOffset)
                
       // }
    }
}
