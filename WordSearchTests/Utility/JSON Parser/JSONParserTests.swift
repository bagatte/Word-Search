//
//  JSONParserTests.swift
//  WordSearchTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class JSONParserTests: XCTestCase {

    // MARK: - Private properties
    
    private let fileReader: FileReadable = FileReader()
    private let jsonParser: JSONParsable = JSONParser()

    // MARK: - Test methods
    
    func testParseWordSearchChallengesCollection() {
        let fileReaderResult = fileReader.contentsOfFile("json_structures", fileType: .text)
        let parseCollectionResult: Result<[WordSearchChallenge]> = jsonParser.parseCollection(fromResult: fileReaderResult)
        
        switch parseCollectionResult {
        case .success(let wordSearchChallenges):
            XCTAssertEqual(wordSearchChallenges.count, 9)
        case .error(let error):
            XCTFail("Filed with error: \(error.localizedDescription)")
        }
    }
}
