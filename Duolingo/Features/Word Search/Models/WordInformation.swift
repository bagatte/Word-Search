//
//  WordInformation.swift
//  Duolingo
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct WordInformation: Hashable {
    
    // MARK: - Public properties
    
    let value: String
    
    let charactersLocation: Set<CharacterLocation>
    
    // MARK: - Init
    
    init?(dictionary: [String: String]) {
        guard let value = dictionary.values.first else {
            return nil
        }
        
        self.value = value
        self.charactersLocation = WordInformation.charactersLocation(dictionary: dictionary)
    }
    
    // MARK: - Private methods
    
    private static func charactersLocation(dictionary: [String: Any]) -> Set<CharacterLocation> {
        guard let locationString = dictionary.keys.first else {
            return Set<CharacterLocation>()
        }
        
        let locationArray = locationString.components(separatedBy: ",")
        var currentColumn: Int = 0
        var characterLocation = Set<CharacterLocation>()
        
        for (index, location) in locationArray.enumerated() {
            guard let location = Int(location) else {
                return Set<CharacterLocation>()
            }
            
            if index % 2 == 0 {
                currentColumn = location
            } else {
                characterLocation.insert(CharacterLocation(row: location, column: currentColumn))
            }
        }
        
        return characterLocation
    }
}
