//
//  WordSearchViewController.swift
//  Duolingo
//
//  Created by bagatte on 3/8/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

class WordSearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var gridCollectionView: UICollectionView!
    @IBOutlet private weak var headerView: WordSearchHeaderView!
    
    // MARK: - Private properties
    
    private var gridController: WordSearchGridController?
    private var originalChallenges: [WordSearchChallenge] = []
    private var availableChallenges: [WordSearchChallenge] = []
    private let wordSearchResource = WordSearchRemoteResource()

    // MARK: - Overridden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Word Search"
        
        gridCollectionView.register(WordSearchGridCell.self)
       
        loadWordSeachChallenges { [weak self] wordSearchChallenges in
            self?.originalChallenges = wordSearchChallenges
            self?.availableChallenges = wordSearchChallenges
            self?.startNextChallenge()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if let flowLayout = gridCollectionView.collectionViewLayout as? WordSearchGridFlowLayout {
            flowLayout.cleanCache()
        }
    }
    
    // MARK: - Private methods
    
    private func loadWordSeachChallenges(_ completion: @escaping (([WordSearchChallenge]) -> Void)) {
        wordSearchResource.wordSearchChallenges { [weak self] result in
            switch result {
            case .success(let wordSearchChallenges):
                completion(wordSearchChallenges)
            case .error(let error):
                self?.showAlertWithError(error)
            }
        }
    }
    
    private func startNextChallenge() {
        guard let nextChallenge = availableChallenges.first else {
            restart()
            return
        }

        gridController = WordSearchGridController(wordSearchChallenge: nextChallenge)
        gridController?.buildGrid()
        headerView.layout(viewModel: WordSearchHeaderViewModel(wordSearchChallenge: nextChallenge))
        setupGridLayout()
    }
    
    private func restart() {
        availableChallenges = originalChallenges
        startNextChallenge()
    }
    
    private func setupGridLayout() {        
        guard
            let rowsAndColumns = gridController?.numberOfRowsAndColumns(),
            let flowLayout = gridCollectionView.collectionViewLayout as? WordSearchGridFlowLayout else {
                return
        }
        flowLayout.set(numberOfRows: rowsAndColumns.rows, numberOfColumns: rowsAndColumns.columns)
        gridCollectionView.reloadData()
        gridCollectionView.layoutIfNeeded()
    }
    
    private func showAlertWithError(_ error: Error) {
        let alert = UIAlertController(title: "OPS!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func resetSelectedCells() {
        gridController?.validSelectedCharactesLocation.forEach { [weak self] in
            guard
                self?.gridController?.isLocationEnabled($0) == true,
                let cell = gridCollectionView.cellForItem(at: IndexPath(item: $0.column, section: $0.row)) as? WordSearchGridCell else {
                    return
            }
            cell.setWhiteBackground()
        }
        gridController?.cleanSelection()
    }
    
    private func updateCells(with locations: Set<CharacterLocation>) {
        gridController?.allSelectedCharactersLocation.forEach { [weak self] in
            guard
                self?.gridController?.isLocationEnabled($0) == true,
                let cell = gridCollectionView.cellForItem(at: IndexPath(item: $0.column, section: $0.row)) as? WordSearchGridCell else {
                    return
            }
            locations.contains($0) ? cell.setYellowBackground() : cell.setWhiteBackground()
        }
    }
    
    // MARK: - Action performer
    
    @objc private func handleGestureRecognizer(_ gesture: UIGestureRecognizer) {
        func selectCharacterAndUpdateCellWithGesture(_ gesture: UIGestureRecognizer) {
            let location: CGPoint = gesture.location(in: gridCollectionView)
            guard
                let indexPath = gridCollectionView.indexPathForItem(at: location),
                let gridController = gridController else {
                    return
            }
            
            gridController.selectCharacterAt(row: indexPath.section, column: indexPath.item)
            
            let cellLocations = gridController.validSelectedCharactesLocation
            updateCells(with: cellLocations)
        }
        
        if gesture.state == .ended {
            if gridController?.isWordValid() == true {
                if gridController?.isChallengeFinished == true {
                    availableChallenges.removeFirst()
                    startNextChallenge()
                } else {
                    gridController?.disableSelectedLocations()
                }
            } else {
                resetSelectedCells()
            }
        } else if gesture.state == .changed || gesture.state == .began {
            selectCharacterAndUpdateCellWithGesture(gesture)
        }
    }
}

// MARK: - Protocol conformance

extension WordSearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gridController?.numberOfRowsAndColumns().rows ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridController?.numberOfRowsAndColumns().columns ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(WordSearchGridCell.self, forIndexPath: indexPath)
        layoutGridCell(cell, at: indexPath)
        return cell
    }
    
    private func layoutGridCell(_ cell: WordSearchGridCell, at indexPath: IndexPath) {
        guard let grid = gridController?.grid else {
            return
        }
        
        if cell.gestureRecognizers == nil {
            let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleGestureRecognizer))
            tapGesture.minimumPressDuration = 0
            cell.addGestureRecognizer(tapGesture)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGestureRecognizer))
            cell.addGestureRecognizer(panGestureRecognizer)
        }
        
        let cellState = grid[indexPath.section][indexPath.item]
        cell.layout(cellState: cellState)
    }
}
