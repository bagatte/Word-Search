//
//  WordSearchResourceTests.swift
//  WordSearchTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class WordSearchResourceTests: XCTestCase {

    // MARK: - Private properties
    
    private let wordSearchResource = WordSearchStaticResource()
    
    // MARK: - Test methods
    
    func testWordSearchChallenges() {
        wordSearchResource.wordSearchChallenges { result in
            switch result {
            case .success(let wordSearchChallenges):
                let wordSearchChallenge = wordSearchChallenges.first!
                
                let characterMatrix = [
                    ["i", "q", "í", "l", "n", "n", "m", "ó"],
                    ["f", "t", "v", "ñ", "b", "m", "h", "a"],
                    ["h", "j", "é", "t", "e", "t", "o", "z"],
                    ["x", "á", "o", "i", "e", "ñ", "m", "é"],
                    ["q", "é", "i", "ó", "q", "s", "b", "s"],
                    ["c", "u", "m", "y", "v", "l", "r", "x"],
                    ["ü", "í", "ó", "m", "o", "t", "e", "k"],
                    ["a", "g", "r", "n", "n", "ó", "s", "m"]
                ]
                
                let characterLocations: Set<CharacterLocation> = [
                    CharacterLocation(row: 1, column: 6),
                    CharacterLocation(row: 2, column: 6),
                    CharacterLocation(row: 3, column: 6),
                    CharacterLocation(row: 4, column: 6),
                    CharacterLocation(row: 5, column: 6),
                    CharacterLocation(row: 6, column: 6),
                ]
                
                XCTAssertEqual("en", wordSearchChallenge.sourceLanguage)
                XCTAssertEqual("man", wordSearchChallenge.word)
                XCTAssertEqual(characterMatrix, wordSearchChallenge.characterMatrix)
                XCTAssertEqual("es", wordSearchChallenge.targetLanguage)
                
                wordSearchChallenge.targetWords.forEach { word in
                    guard word.value == "hombre" else {
                        XCTFail()
                        return
                    }
                    
                    XCTAssertEqual(word.charactersLocation, characterLocations)
                }
            case .error(let error):
                XCTFail("Result failed with error: \(error)")
            }
        }
    }
}
