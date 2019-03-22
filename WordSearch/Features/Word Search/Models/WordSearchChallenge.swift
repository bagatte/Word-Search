//
//  WordSearchChallenge.swift
//  WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct WordSearchChallenge: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case sourceLanguage = "source_language"
        case word
        case characterMatrix = "character_grid"
        case targetLanguage = "target_language"
        case wordLocations = "word_locations"
    }

    // MARK: - Public properties
    
    let sourceLanguage: String
    
    let word: String
    
    let characterMatrix: [[String]]
    
    let targetLanguage: String
    
    var targetWords: Set<WordInformation> {
        var translatedWords = Set<WordInformation>()
        for dictionary in wordLocations {
            guard let word = WordInformation(dictionary: [dictionary.key: dictionary.value]) else {
                continue
            }
            translatedWords.insert(word)
        }
        return translatedWords
    }
    
    // MARK: - Private properties
    
    private let wordLocations: [String: String]
}
