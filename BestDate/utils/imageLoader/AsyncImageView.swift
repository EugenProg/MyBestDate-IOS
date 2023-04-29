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
    private let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"

    @State var url: String?

    fileprivate func placeholder() -> some View {
        LoadingDotsView()
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

struct UpdateWithThumbImageView: View {
    private let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"

    @Binding var image: ProfileImage?

    @State var fullImageIsLoaded: Bool = false

    fileprivate func placeholder() -> some View {
        LoadingDotsView()
    }

    var body: some View {
        ZStack {
            if !fullImageIsLoaded {
                KFImage.url(getUrl(image?.thumb_url))
                    .placeholder(placeholder)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onProgress { receivedSize, totalSize in }
                    .onSuccess { result in  }
                    .onFailure { error in }
                    .resizable()
            }

            KFImage.url(getUrl(image?.full_url))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .onProgress { receivedSize, totalSize in }
                .onSuccess { result in
                    fullImageIsLoaded = true
                }
                .onFailure { error in }
                .resizable()
        }
    }

    private func getUrl(_ url: String?) -> URL {
        URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)!
    }
}

struct UpdateImageView: View {
    private let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"

    @Binding var image: ProfileImage?
    var smallUrl: Bool = true

    fileprivate func placeholder() -> some View {
        LoadingDotsView()
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
    private let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"

    @Binding var user: ShortUserInfo?

    fileprivate func placeholder() -> some View {
        LoadingDotsView()
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
    private let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"

    @Binding var message: Message?
    var smallUrl: Bool = true

    fileprivate func placeholder() -> some View {
        LoadingDotsView()
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

struct ChatWithThumbImageView: View {
    private let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"

    @Binding var image: ChatImage?

    @State var fullImageIsLoaded: Bool = false

    fileprivate func placeholder() -> some View {
        LoadingDotsView()
    }

    var body: some View {
        ZStack {
            if !fullImageIsLoaded {
                KFImage.url(getUrl(image?.thumb_url))
                    .placeholder(placeholder)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onProgress { receivedSize, totalSize in }
                    .onSuccess { result in  }
                    .onFailure { error in }
                    .resizable()
            }

            KFImage.url(getUrl(image?.full_url))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .onProgress { receivedSize, totalSize in }
                .onSuccess { result in
                    fullImageIsLoaded = true
                }
                .onFailure { error in }
                .resizable()
        }
    }

    private func getUrl(_ url: String?) -> URL {
        URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)!
    }
}

struct MatchImageView: View {
    private let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"

    @Binding var match: MatchItem
    @Binding var currentIndex: Int

    fileprivate func placeholder() -> some View {
        LoadingDotsView()
    }

    var body: some View {
        ZStack {
            if ((currentIndex - 1)...(currentIndex + 2)) ~= currentIndex {
                KFImage.url(getUrl(match.user?.main_photo?.thumb_url))
                    .placeholder(placeholder)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onProgress { receivedSize, totalSize in }
                    .onSuccess { result in  }
                    .onFailure { error in }
                    .resizable()

                KFImage.url(getUrl(match.user?.main_photo?.full_url))
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .onProgress { receivedSize, totalSize in }
                    .onSuccess { result in }
                    .onFailure { error in }
                    .resizable()
            }
        }.background(
            RoundedRectangle(cornerRadius: 32)
                .fill(ColorList.main.color)
        )
    }

    private func getUrl(_ url: String?) -> URL {
        URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)!
    }
}

struct AsyncWithThumbImageView: View {
    private let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"

    @State var thumbUrl: String?
    @State var fullUrl: String?

    @State var fullImageIsLoaded: Bool = false

    fileprivate func placeholder() -> some View {
        LoadingDotsView()
    }

    var body: some View {
        ZStack {
            if !fullImageIsLoaded {
                KFImage.url(getUrl(thumbUrl))
                    .placeholder(placeholder)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onProgress { receivedSize, totalSize in }
                    .onSuccess { result in  }
                    .onFailure { error in }
                    .resizable()
            }

            KFImage.url(getUrl(fullUrl))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .onProgress { receivedSize, totalSize in }
                .onSuccess { result in
                    fullImageIsLoaded = true
                }
                .onFailure { error in }
                .resizable()
        }
    }

    private func getUrl(_ url: String?) -> URL {
        URL(string: (url == nil || url?.isEmpty == true) ? defaultUrl : url ?? defaultUrl)!
    }
}
