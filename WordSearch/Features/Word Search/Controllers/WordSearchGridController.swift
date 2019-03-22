//
//  WordSearchGridController.swift
//  WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

class WordSearchGridController {
    
    enum GridCellState {
        case enabled(character: String)
        case disabled(character: String)
    }
    
    // MARK: - Private properties
    
    private(set) var grid: [[GridCellState]]
    private(set) var validSelectedCharactesLocation: Set<CharacterLocation>
    private(set) var allSelectedCharactersLocation = Set<CharacterLocation>()
    private var wordSearchChallenge: WordSearchChallenge
    private var targetWords: Set<WordInformation>
    private var firstSelectionLocation: CharacterLocation?
    private var lastSelectionLocation: CharacterLocation?
    
    // MARK: - Public properties
    
    var isChallengeFinished: Bool {
        return targetWords.isEmpty
    }
    
    // MARK: - Init
    
    init(wordSearchChallenge: WordSearchChallenge) {
        self.grid = []
        self.validSelectedCharactesLocation = Set<CharacterLocation>()
        self.wordSearchChallenge = wordSearchChallenge
        self.targetWords = wordSearchChallenge.targetWords
    }
    
    // MARK: - Public methods
    
    func buildGrid() {
        let characterMatrix = wordSearchChallenge.characterMatrix
        let numberOfRows = characterMatrix.count
        let numberOfColumns = characterMatrix[0].count
        
        grid = [[GridCellState]](repeating: [], count: numberOfRows)
        
        for rowIndex in 0..<numberOfRows {
            for columnIndex in 0..<numberOfColumns {
                let character = characterMatrix[rowIndex][columnIndex]
                grid[rowIndex].append(.enabled(character: character))
            }
        }
    }
    
    func selectCharacterAt(row: Int, column: Int) {
        guard case GridCellState.enabled = grid[row][column] else {
            return
        }
        
        if validSelectedCharactesLocation.isEmpty {
            firstSelectionLocation = CharacterLocation(row: row, column: column)
        }
        
        lastSelectionLocation = CharacterLocation(row: row, column: column)
        
        validSelectedCharactesLocation = validSelectedCharactesLocations()
    }
    
    func cleanSelection() {
        firstSelectionLocation = nil
        lastSelectionLocation = nil
        validSelectedCharactesLocation.removeAll()
        allSelectedCharactersLocation.removeAll()
    }
    
    func isWordValid() -> Bool {
        outter: for targetWord in targetWords {
            guard validSelectedCharactesLocation.count == targetWord.value.count else {
                continue
            }

            for location in validSelectedCharactesLocation where !targetWord.charactersLocation.contains(location) {
                continue outter
            }
            
            remove(word: targetWord)
            
            return true
        }
        
        return false
    }
    
    func numberOfRowsAndColumns() -> (rows: Int, columns: Int) {
        let numberOfRows = grid.count
        let numberOfColumns = grid[0].count
        return (rows: numberOfRows, columns: numberOfColumns)
    }
    
    func disableSelectedLocations() {
        validSelectedCharactesLocation.forEach { [weak self] in
            guard
                let grid = self?.grid,
                case GridCellState.enabled(let character) = grid[$0.row][$0.column] else {
                    return
            }
            self?.grid[$0.row][$0.column] = .disabled(character: character)
        }
    }
    
    func isLocationEnabled(_ location: CharacterLocation) -> Bool {
        guard case WordSearchGridController.GridCellState.enabled = grid[location.row][location.column] else {
            return false
        }
        return true
    }
    
    // MARK: - Private methods
    
    private func remove(word: WordInformation) {
        targetWords.remove(word)
    }
    
    private func validSelectedCharactesLocations() -> Set<CharacterLocation> {
        guard
            let firstTapLocation = firstSelectionLocation,
            let lastTapLocation = lastSelectionLocation else {
                return Set<CharacterLocation>()
        }
        
        var locations = Set<CharacterLocation>()
        
        func horizontalLocations() {
            var currentColumn = firstTapLocation.column
            while currentColumn <= lastTapLocation.column {
                let characterLocation = CharacterLocation(row: firstTapLocation.row, column: currentColumn)
                locations.insert(characterLocation)
                allSelectedCharactersLocation.insert(characterLocation)
                currentColumn += 1
            }
        }
        
        func verticallLocations() {
            var currentRow = firstTapLocation.row
            while currentRow <= lastTapLocation.row {
                let characterLocation = CharacterLocation(row: currentRow, column: firstTapLocation.column)
                locations.insert(characterLocation)
                allSelectedCharactersLocation.insert(characterLocation)
                currentRow += 1
            }
        }
        
        func diagonalLocations() {
            var currentRow = firstTapLocation.row
            var currentColumn = firstTapLocation.column
            
            while currentRow <= lastTapLocation.row && currentColumn <= lastTapLocation.column {
                let characterLocation = CharacterLocation(row: currentRow, column: currentColumn)
                locations.insert(characterLocation)
                allSelectedCharactersLocation.insert(characterLocation)
                currentRow += 1
                currentColumn += 1
            }
        }
        
        if firstTapLocation.row == lastTapLocation.row {
            horizontalLocations()
        } else if firstTapLocation.column == lastTapLocation.column {
            verticallLocations()
        } else if lastTapLocation.row >= firstTapLocation.row && lastTapLocation.column >= firstTapLocation.column {
            diagonalLocations()
        }
        
        return locations
    }
}
