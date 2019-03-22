//
//  NetworkingErrorTests.swift
//  WordSearchTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class NetworkingErrorTests: XCTestCase {
    
    // MARK: - Test methods

    func testServerErrorWithDescription() {
        let errorDescription = "Something wrong with the server."
        
        do {
            try throwError(NetworkingError.serverError(description: errorDescription))
        } catch {
            guard case NetworkingError.serverError(let description) = error else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(description!, errorDescription)
        }
    }
    
    func testServerErrorWithoutDescription() {
        do {
            try throwError(NetworkingError.serverError(description: nil))
        } catch {
            guard case NetworkingError.serverError(let description) = error else {
                XCTFail()
                return
            }
        
            XCTAssertNil(description)
        }
    }
    
    func testUnknownError() {
        do {
            try throwError(NetworkingError.unknown)
        } catch {
            guard case NetworkingError.unknown = error else {
                XCTFail()
                return
            }
        }
    }
    
    // MARK: - Private methods
    
    private func throwError(_ error: NetworkingError) throws {
        throw error
    }
}
