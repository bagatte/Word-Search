//
//  FileReaderTests.swift
//  DuolingoTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class FileReaderTests: XCTestCase {

    // MARK: - Private properties
    
    private let fileReader: FileReadable = FileReader()

    // MARK: - Test methods
    
    func testReadJsonStructuresFileSucceeds() {
        let result = fileReader.contentsOfFile("json_structures", fileType: .text)
        switch result {
        case .success:
            break
        case .error(let error):
            XCTFail("Filed with error: \(error.localizedDescription)")
        }
    }
    
    func testReadNotExistingFileFails() {
        let result = fileReader.contentsOfFile("not_existing_file", fileType: .text)
        switch result {
        case .success:
            XCTFail()
        case .error:
            break
        }
    }
}
