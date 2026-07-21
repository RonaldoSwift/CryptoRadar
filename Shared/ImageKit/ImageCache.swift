//
//  ImageCache.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/07/26.
//

import Foundation
import UIKit

actor ImageCache {

    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) async throws -> UIImage {
        if let image = cache.object(forKey: url as NSURL) {
            return image
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }

        cache.setObject(image, forKey: url as NSURL)
        return image
    }
}
