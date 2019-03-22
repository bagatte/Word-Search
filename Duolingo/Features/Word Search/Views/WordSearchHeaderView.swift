//
//  WordSearchHeaderView.swift
//  Duolingo
//
//  Created by bagatte on 3/10/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

class WordSearchHeaderView: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var sourceWordValueLabel: UILabel!
    @IBOutlet private weak var targetWordsValueLabel: UILabel!
    
    func layout(viewModel: WordSearchHeaderViewModel) {
        sourceWordValueLabel.text = viewModel.sourceWord
        targetWordsValueLabel.text = viewModel.targetWords
    }
}
