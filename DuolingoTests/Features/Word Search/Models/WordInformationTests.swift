//
//  WordInformationTests.swift
//  DuolingoTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class WordInformationTests: XCTestCase {

    func testWordInformationInitializer() {
        
        let charactersLocation: Set<CharacterLocation> = [
            CharacterLocation(row: 2, column: 5),
            CharacterLocation(row: 3, column: 5),
            CharacterLocation(row: 4, column: 5),
            CharacterLocation(row: 5, column: 5)
        ]
        
        let wordInformation = WordInformation(dictionary: ["5,2,5,3,5,4,5,5": "niño"])
        XCTAssertEqual(wordInformation?.value, "niño")
        XCTAssertEqual(wordInformation?.charactersLocation, charactersLocation)
    }
}
