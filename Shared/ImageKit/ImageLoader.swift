//
//  ImageLoader.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/07/26.
//

import Foundation
import UIKit
import SwiftUI
import Combine

@MainActor
final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    func load(from urlString: String) {
        
        guard image == nil else { return }
        guard let url = URL(string: urlString) else {
            return
        }
        
        Task {
            do {
                image = try await ImageCache.shared.image(for: url)
            } catch {
                print(error)
            }
        }
    }
}
