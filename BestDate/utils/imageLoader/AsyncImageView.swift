//
//  AsyncImage.swift
//  BestDate
//
//  Created by Евгений on 06.07.2022.
//

import SwiftUI
import Combine
import Foundation

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    private let defaultUrl: String = "https://image.shutterstock.com/image-vector/sad-apologizing-emoticon-emoji-holding-260nw-1398672683.jpg"

    init(url: String?) {
        let realUrl = URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)
        _loader = StateObject(wrappedValue: ImageLoader(url: realUrl!, cache: Environment(\.imageCache).wrappedValue))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                Text("loading...")
                    .foregroundColor(ColorList.blue.color)
                    .font(MyFont.getFont(.ITALIC, 12))
            }
        }
    }
}

