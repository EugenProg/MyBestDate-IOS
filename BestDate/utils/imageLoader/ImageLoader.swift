//
//  ImageLoader.swift
//  BestDate
//
//  Created by Евгений on 06.07.2022.
//

import SwiftUI
import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var url: URL
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    private(set) var isLoading = false
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }

    deinit {
        cancel()
    }

    func update(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
        load()
    }

    func load() {
        guard !isLoading else { return }
        if let image = cache?[url] {
            self.image = image
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue)
            .map{ UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
            }
    }

    func cancel() {
        cancellable?.cancel()
    }

    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }

    private func onStart() {
        isLoading = true
    }

    private func onFinish() {
        isLoading = false
    }
}

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? {get set}
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()

    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
