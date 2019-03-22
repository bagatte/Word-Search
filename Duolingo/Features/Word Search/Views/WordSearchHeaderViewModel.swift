//
//  WordSearchHeaderViewModel.swift
//  Duolingo
//
//  Created by bagatte on 3/10/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct WordSearchHeaderViewModel {

    let sourceWord: String
    
    let targetWords: String
    
    init(wordSearchChallenge: WordSearchChallenge) {
        sourceWord = wordSearchChallenge.word
        
        var formattedTargetWords: String = ""
        wordSearchChallenge.targetWords.forEach {
            formattedTargetWords.append("\($0.value)\n")
        }
        targetWords = formattedTargetWords
    }
}
