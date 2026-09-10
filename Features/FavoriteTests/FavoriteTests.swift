//
//  FavoriteTests.swift
//  FavoriteTests
//
//  Created by Ronaldo Andre on 12/06/26.
//

import XCTest
@testable import Favorite

final class FavoriteTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFavoriteBurstAnimationResourceExists() {
        let animationURL = Bundle.module.url(forResource: "favorite_burst", withExtension: "json")
        XCTAssertNotNil(animationURL, "The Lottie favorite animation JSON should be bundled with Favorite module.")
    }

}
