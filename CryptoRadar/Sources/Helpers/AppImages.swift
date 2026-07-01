//
//  AppImages.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 18/06/26.
//

import Foundation

enum AppImages {

    static let searchList = image("searchList")
    static let favorite = system("star.fill")
    static let settings = system("slider.horizontal.3")
    
    static let settingsConfiguracion = "gearshape.fill"

    private static func image(_ name: String) -> String {
        name
    }
    private static func system(_ name: String) -> String {
        name
    }
}
