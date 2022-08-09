//
//  AsyncImage.swift
//  BestDate
//
//  Created by Евгений on 06.07.2022.
//

import SwiftUI
import Combine
import Foundation
import Kingfisher

struct AsyncImageView: View {
    private let defaultUrl: String = "https://image.shutterstock.com/image-vector/sad-apologizing-emoticon-emoji-holding-260nw-1398672683.jpg"

    @State var url: String?

    fileprivate func placeholder() -> some View {
        Text("loading...")
            .foregroundColor(ColorList.blue.color)
            .font(MyFont.getFont(.ITALIC, 12))
    }

    var body: some View {
        let realUrl = URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)
        KFImage.url(realUrl)
            .placeholder(placeholder)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in }
            .onSuccess { result in  }
            .onFailure { error in }
            .resizable()
    }
}

struct UpdateImageView: View {
    private let defaultUrl: String = "https://image.shutterstock.com/image-vector/sad-apologizing-emoticon-emoji-holding-260nw-1398672683.jpg"

    @Binding var image: ProfileImage?
    var smallUrl: Bool = true

    fileprivate func placeholder() -> some View {
        Text("loading...")
            .foregroundColor(ColorList.blue.color)
            .font(MyFont.getFont(.ITALIC, 12))
    }

    var body: some View {
        let url = smallUrl ? image?.thumb_url : image?.full_url
        let realUrl = URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)
        KFImage.url(realUrl)
            .placeholder(placeholder)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in }
            .onSuccess { result in  }
            .onFailure { error in }
            .resizable()
    }
}

struct UserImageView: View {
    private let defaultUrl: String = "https://image.shutterstock.com/image-vector/sad-apologizing-emoticon-emoji-holding-260nw-1398672683.jpg"

    @Binding var user: ShortUserInfo?

    fileprivate func placeholder() -> some View {
        Text("loading...")
            .foregroundColor(ColorList.blue.color)
            .font(MyFont.getFont(.ITALIC, 12))
    }

    var body: some View {
        let url = user?.main_photo?.thumb_url
        let realUrl = URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)
        KFImage.url(realUrl)
            .placeholder(placeholder)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in }
            .onSuccess { result in  }
            .onFailure { error in }
            .resizable()
    }
}

struct ChatImageView: View {
    private let defaultUrl: String = "https://image.shutterstock.com/image-vector/sad-apologizing-emoticon-emoji-holding-260nw-1398672683.jpg"

    @Binding var message: Message?
    var smallUrl: Bool = true

    fileprivate func placeholder() -> some View {
        Text("loading...")
            .foregroundColor(ColorList.blue.color)
            .font(MyFont.getFont(.ITALIC, 12))
    }

    var body: some View {
        let url = smallUrl ? message?.image?.thumb_url : message?.image?.full_url
        let realUrl = URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)
        KFImage.url(realUrl)
            .placeholder(placeholder)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in }
            .onSuccess { result in  }
            .onFailure { error in }
            .resizable()
    }
}
