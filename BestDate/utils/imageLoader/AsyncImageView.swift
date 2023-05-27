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
    @State var url: String?

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
    @Binding var image: ProfileImage?

    @State var fullImageIsLoaded: Bool = false

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
    @Binding var image: ProfileImage?
    var smallUrl: Bool = true

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
    @Binding var user: ShortUserInfo?

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
    @Binding var message: Message?
    var smallUrl: Bool = true

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
    @Binding var image: ChatImage?

    @State var fullImageIsLoaded: Bool = false

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
    @Binding var match: MatchItem
    @Binding var currentIndex: Int

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
    @State var thumbUrl: String?
    @State var fullUrl: String?

    @State var fullImageIsLoaded: Bool = false

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

fileprivate func hasConnection() -> Bool {
    NetworkManager.shared.isConnected
}

fileprivate func placeholder() -> some View {
    ZStack {
        if hasConnection() {
            LoadingDotsView()
        } else {
            Image("ic_default_image")
                .resizable()
        }
    }
}

fileprivate let defaultUrl: String = "\(CoreApiTypes.serverAddress)/images/default_photo.jpg"
