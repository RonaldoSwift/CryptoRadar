//
//  CachedAsyncImage.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/07/26.
//

import Foundation
import SwiftUI

public struct CachedAsyncImage: View {

    let url: String
    @StateObject private var loader = ImageLoader()
    
    public init(url: String) {
           self.url = url
       }

    public var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loader.load(from: url)
        }
    }
}
