//
//  AppRootManager.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 27/05/26.
//

import Foundation
internal import Combine

final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: AppRoots = .authentication
    
    enum AppRoots {
        case authentication
        case principal
    }
}
