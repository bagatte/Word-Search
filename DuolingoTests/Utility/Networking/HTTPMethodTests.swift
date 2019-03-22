//
//  HTTPMethodTests.swift
//  WordSearchTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class HTTPMethodTests: XCTestCase {

    func testGetHTTPMethod() {
        let method: HTTPMethod = .get
        XCTAssertEqual("GET", method.rawValue, "HTTP method rawValue doesn't match.")
    }
}
