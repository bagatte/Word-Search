//
//  FileTypeTests.swift
//  WordSearchTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class FileTypeTests: XCTestCase {

    func testTextFileType() {
        let textType = FileType.text
        XCTAssertEqual(textType.rawValue, "txt")
    }
    
}
