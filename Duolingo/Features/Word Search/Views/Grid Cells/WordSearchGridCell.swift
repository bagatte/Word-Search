//
//  WordSearchGridCell.swift
//  Duolingo
//
//  Created by bagatte on 3/10/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

class WordSearchGridCell: UICollectionViewCell, NibLoadable {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var characterLabel: UILabel!

    // MARK: - Public methods
    
    func layout(cellState: WordSearchGridController.GridCellState) {
        switch cellState {
        case .enabled(let character):
            characterLabel.text = character
            setWhiteBackground()
        case .disabled(let character):
            characterLabel.text = character
            setYellowBackground()
        }
    }
    
    func setWhiteBackground() {
        backgroundColor = .white
    }
    
    func setYellowBackground() {
        backgroundColor = .yellow
    }
}
