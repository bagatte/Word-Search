//
//  FileReaderErrorTests.swift
//  WordSearchTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class FileReaderErrorTests: XCTestCase {
    
    // MARK: - Test methods

    func testnotFoundError() {
        do {
            try throwError(FileReaderError.notFound)
        } catch {
            guard case FileReaderError.notFound = error else {
                XCTFail()
                return
            }
        }
    }
    
    // MARK: - Private methods
    
    private func throwError(_ error: FileReaderError) throws {
        throw error
    }
}
