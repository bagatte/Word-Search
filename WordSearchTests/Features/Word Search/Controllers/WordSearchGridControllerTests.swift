//
//  WordSearchGridControllerTests.swift
//  WordSearchTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class WordSearchGridControllerTests: XCTestCase {
    
    private var wordSearchGridController: WordSearchGridController!
    
    // MARK: - Test methods

    func testsBuildGrid() {
        buildGrid(with: loadWordSearchChallenge(at: 0))
        
        let grid = [
            [WordSearchGridController.GridCellState.enabled(character: "i"), WordSearchGridController.GridCellState.enabled(character: "q"), WordSearchGridController.GridCellState.enabled(character: "í"), WordSearchGridController.GridCellState.enabled(character: "l"), WordSearchGridController.GridCellState.enabled(character: "n"), WordSearchGridController.GridCellState.enabled(character: "n"), WordSearchGridController.GridCellState.enabled(character: "m"), WordSearchGridController.GridCellState.enabled(character: "ó")],
            [WordSearchGridController.GridCellState.enabled(character: "f"), WordSearchGridController.GridCellState.enabled(character: "t"), WordSearchGridController.GridCellState.enabled(character: "v"), WordSearchGridController.GridCellState.enabled(character: "ñ"), WordSearchGridController.GridCellState.enabled(character: "b"), WordSearchGridController.GridCellState.enabled(character: "m"), WordSearchGridController.GridCellState.enabled(character: "h"), WordSearchGridController.GridCellState.enabled(character: "a")],
            [WordSearchGridController.GridCellState.enabled(character: "h"), WordSearchGridController.GridCellState.enabled(character: "j"), WordSearchGridController.GridCellState.enabled(character: "é"), WordSearchGridController.GridCellState.enabled(character: "t"), WordSearchGridController.GridCellState.enabled(character: "e"), WordSearchGridController.GridCellState.enabled(character: "t"), WordSearchGridController.GridCellState.enabled(character: "o"), WordSearchGridController.GridCellState.enabled(character: "z")],
            [WordSearchGridController.GridCellState.enabled(character: "x"), WordSearchGridController.GridCellState.enabled(character: "á"), WordSearchGridController.GridCellState.enabled(character: "o"), WordSearchGridController.GridCellState.enabled(character: "i"), WordSearchGridController.GridCellState.enabled(character: "e"), WordSearchGridController.GridCellState.enabled(character: "ñ"), WordSearchGridController.GridCellState.enabled(character: "m"), WordSearchGridController.GridCellState.enabled(character: "é")],
            [WordSearchGridController.GridCellState.enabled(character: "q"), WordSearchGridController.GridCellState.enabled(character: "é"), WordSearchGridController.GridCellState.enabled(character: "i"), WordSearchGridController.GridCellState.enabled(character: "ó"), WordSearchGridController.GridCellState.enabled(character: "q"), WordSearchGridController.GridCellState.enabled(character: "s"), WordSearchGridController.GridCellState.enabled(character: "b"), WordSearchGridController.GridCellState.enabled(character: "s")],
            [WordSearchGridController.GridCellState.enabled(character: "c"), WordSearchGridController.GridCellState.enabled(character: "u"), WordSearchGridController.GridCellState.enabled(character: "m"), WordSearchGridController.GridCellState.enabled(character: "y"), WordSearchGridController.GridCellState.enabled(character: "v"), WordSearchGridController.GridCellState.enabled(character: "l"), WordSearchGridController.GridCellState.enabled(character: "r"), WordSearchGridController.GridCellState.enabled(character: "x")],
            [WordSearchGridController.GridCellState.enabled(character: "ü"), WordSearchGridController.GridCellState.enabled(character: "í"), WordSearchGridController.GridCellState.enabled(character: "ó"), WordSearchGridController.GridCellState.enabled(character: "m"), WordSearchGridController.GridCellState.enabled(character: "o"), WordSearchGridController.GridCellState.enabled(character: "t"), WordSearchGridController.GridCellState.enabled(character: "e"), WordSearchGridController.GridCellState.enabled(character: "k")],
            [WordSearchGridController.GridCellState.enabled(character: "a"), WordSearchGridController.GridCellState.enabled(character: "g"), WordSearchGridController.GridCellState.enabled(character: "r"), WordSearchGridController.GridCellState.enabled(character: "n"), WordSearchGridController.GridCellState.enabled(character: "n"), WordSearchGridController.GridCellState.enabled(character: "ó"), WordSearchGridController.GridCellState.enabled(character: "s"), WordSearchGridController.GridCellState.enabled(character: "m")]
        ]
        
        XCTAssertEqual(wordSearchGridController.grid.count, grid.count)
    }
    
    func testSelectCharacterAtRowAndColumn() {
        buildGrid(with: loadWordSearchChallenge(at: 0))
        
        wordSearchGridController.selectCharacterAt(row: 1, column: 6)
        wordSearchGridController.selectCharacterAt(row: 2, column: 6)
        wordSearchGridController.selectCharacterAt(row: 3, column: 6)
        
        XCTAssertTrue(wordSearchGridController.validSelectedCharactesLocation.contains(CharacterLocation(row: 1, column: 6)))
        XCTAssertTrue(wordSearchGridController.validSelectedCharactesLocation.contains(CharacterLocation(row: 2, column: 6)))
        XCTAssertTrue(wordSearchGridController.validSelectedCharactesLocation.contains(CharacterLocation(row: 3, column: 6)))
    }
    
    func testCleanCurrentSelection() {
        buildGrid(with: loadWordSearchChallenge(at: 0))
        
        wordSearchGridController.selectCharacterAt(row: 1, column: 6)
        wordSearchGridController.selectCharacterAt(row: 2, column: 6)
        wordSearchGridController.selectCharacterAt(row: 3, column: 6)
        
        wordSearchGridController.cleanSelection()
        
        XCTAssertTrue(wordSearchGridController.validSelectedCharactesLocation.isEmpty)
    }
    
    func testSelectInvalidWordVertically() {
        buildGrid(with: loadWordSearchChallenge(at: 0))
        
        wordSearchGridController.selectCharacterAt(row: 1, column: 6)
        wordSearchGridController.selectCharacterAt(row: 2, column: 6)
        wordSearchGridController.selectCharacterAt(row: 3, column: 6)
        
        XCTAssertFalse(wordSearchGridController.isWordValid())
    }
    
    func testSelectInvalidWordHorizontally() {
        buildGrid(with: loadWordSearchChallenge(at: 8))
        
        wordSearchGridController.selectCharacterAt(row: 0, column: 2)
        wordSearchGridController.selectCharacterAt(row: 0, column: 3)
        
        XCTAssertFalse(wordSearchGridController.isWordValid())
    }
    
    func testSelectInvalidWordDiagonally() {
        buildGrid(with: loadWordSearchChallenge(at: 7))
        
        wordSearchGridController.selectCharacterAt(row: 0, column: 2)
        wordSearchGridController.selectCharacterAt(row: 1, column: 3)
        wordSearchGridController.selectCharacterAt(row: 2, column: 4)
        
        XCTAssertFalse(wordSearchGridController.isWordValid())
    }
    
    func testSelectValidWordVertically() {
        buildGrid(with: loadWordSearchChallenge(at: 0))
        
        wordSearchGridController.selectCharacterAt(row: 1, column: 6)
        wordSearchGridController.selectCharacterAt(row: 2, column: 6)
        wordSearchGridController.selectCharacterAt(row: 3, column: 6)
        wordSearchGridController.selectCharacterAt(row: 4, column: 6)
        wordSearchGridController.selectCharacterAt(row: 5, column: 6)
        wordSearchGridController.selectCharacterAt(row: 6, column: 6)
        
        XCTAssertTrue(wordSearchGridController.isWordValid())
    }
    
    func testSelectValidWordHorizontally() {
        buildGrid(with: loadWordSearchChallenge(at: 8))
        
        wordSearchGridController.selectCharacterAt(row: 0, column: 2)
        wordSearchGridController.selectCharacterAt(row: 0, column: 3)
        wordSearchGridController.selectCharacterAt(row: 0, column: 4)
        
        XCTAssertTrue(wordSearchGridController.isWordValid())
    }
    
    func testSelectValidWordDiagonally() {
        buildGrid(with: loadWordSearchChallenge(at: 7))
        
        wordSearchGridController.selectCharacterAt(row: 0, column: 2)
        wordSearchGridController.selectCharacterAt(row: 1, column: 3)
        wordSearchGridController.selectCharacterAt(row: 2, column: 4)
        wordSearchGridController.selectCharacterAt(row: 3, column: 5)
        
        XCTAssertTrue(wordSearchGridController.isWordValid())
    }
    
    func testFinishChallengeSelectingSingleValidWord() {
        buildGrid(with: loadWordSearchChallenge(at: 0))
        
        wordSearchGridController.selectCharacterAt(row: 1, column: 6)
        wordSearchGridController.selectCharacterAt(row: 2, column: 6)
        wordSearchGridController.selectCharacterAt(row: 3, column: 6)
        wordSearchGridController.selectCharacterAt(row: 4, column: 6)
        wordSearchGridController.selectCharacterAt(row: 5, column: 6)
        wordSearchGridController.selectCharacterAt(row: 6, column: 6)
        
        XCTAssertTrue(wordSearchGridController.isWordValid())
        XCTAssertTrue(wordSearchGridController.isChallengeFinished)
    }
    
    func testFinishChallengeSelectingMultipleValidWords() {
        buildGrid(with: loadWordSearchChallenge(at: 2))
        
        wordSearchGridController.selectCharacterAt(row: 2, column: 5)
        wordSearchGridController.selectCharacterAt(row: 3, column: 5)
        wordSearchGridController.selectCharacterAt(row: 4, column: 5)
        wordSearchGridController.selectCharacterAt(row: 5, column: 5)
        
        XCTAssertTrue(wordSearchGridController.isWordValid())
        XCTAssertFalse(wordSearchGridController.isChallengeFinished)
        
        wordSearchGridController.cleanSelection()
        
        wordSearchGridController.selectCharacterAt(row: 0, column: 4)
        wordSearchGridController.selectCharacterAt(row: 1, column: 4)
        wordSearchGridController.selectCharacterAt(row: 2, column: 4)
        wordSearchGridController.selectCharacterAt(row: 3, column: 4)
        wordSearchGridController.selectCharacterAt(row: 4, column: 4)
        
        XCTAssertTrue(wordSearchGridController.isWordValid())
        XCTAssertTrue(wordSearchGridController.isChallengeFinished)
    }
    
    func testGridNumberOfRowsAndColumns() {
        buildGrid(with: loadWordSearchChallenge(at: 0))
        
        let rowsAndColumns = wordSearchGridController.numberOfRowsAndColumns()
        
        XCTAssertEqual(rowsAndColumns.rows, 8)
        XCTAssertEqual(rowsAndColumns.columns, 8)
    }
    
    func testDisableLocationsInGrid() {
        buildGrid(with: loadWordSearchChallenge(at: 2))
        
        wordSearchGridController.selectCharacterAt(row: 2, column: 5)
        wordSearchGridController.selectCharacterAt(row: 3, column: 5)
        wordSearchGridController.selectCharacterAt(row: 4, column: 5)
        wordSearchGridController.selectCharacterAt(row: 5, column: 5)
        
        XCTAssertTrue(wordSearchGridController.isWordValid())
        XCTAssertFalse(wordSearchGridController.isChallengeFinished)
        
        wordSearchGridController.disableSelectedLocations()
        
        guard case WordSearchGridController.GridCellState.disabled(_) = wordSearchGridController.grid[2][5] else {
            XCTFail()
            return
        }
    }
    
    // MARK: - Private methods
    
    private func buildGrid(with wordSearchChallenge: WordSearchChallenge) {
        wordSearchGridController = WordSearchGridController(wordSearchChallenge: wordSearchChallenge)
        wordSearchGridController.buildGrid()
    }
    
    private func loadWordSearchChallenge(at index: Int) -> WordSearchChallenge {
        let fileReaderResult = FileReader().contentsOfFile("json_structures", fileType: .text)
        let parseCollectionResult: Result<[WordSearchChallenge]> = JSONParser().parseCollection(fromResult: fileReaderResult)
        
        switch parseCollectionResult {
        case .success(let wordSearchChallenges):
            return wordSearchChallenges[index]
        case .error:
            fatalError()
        }
    }
}
