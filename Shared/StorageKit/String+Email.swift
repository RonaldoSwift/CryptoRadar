//
//  String+Email.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 6/08/26.
//

import Foundation

public extension String {

    var isValidEmail: Bool {

        let emailRegex =
        "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"

        return NSPredicate(
            format: "SELF MATCHES %@",
            emailRegex
        )
        .evaluate(with: self)
    }
}
