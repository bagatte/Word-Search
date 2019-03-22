//
//  EndpointTests.swift
//  DuolingoTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class EndpointTests: XCTestCase {

    func testEndpointInitializer() {
        let path = "http://www.duolingo.com"
        let httpMethod = HTTPMethod.get

        let endpoint = Endpoint(path: path, method: httpMethod)

        XCTAssertEqual(endpoint.path, path)
        XCTAssertEqual(endpoint.method, httpMethod)
    }
}
