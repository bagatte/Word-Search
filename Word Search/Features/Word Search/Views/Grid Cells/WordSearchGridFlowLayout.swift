//
//  WordSearchGridFlowLayout.swift
//  WordSearch
//
//  Created by bagatte on 3/10/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

class WordSearchGridFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Private properties

    private var numberOfColumns = 0
    private var numberOfRows = 0
    private var cache = [Int: UICollectionViewLayoutAttributes]()
    private var contentSize: CGSize {
        guard let collectionView = collectionView else {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    // MARK: - Overriden properties
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    // MARK: - Overriden methods
    
    override func prepare() {
        guard cache.isEmpty else {
            return
        }
        setup(numberOfRows: numberOfRows, numberOfColumns: numberOfColumns)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache.values where attributes.frame.intersects(rect) {
            layoutAttributes.append(attributes)
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    // MARK: - Public methods
    
    func set(numberOfRows: Int, numberOfColumns: Int) {
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        cleanCache()
    }
    
    func cleanCache() {
        cache.removeAll()
    }
    
    // MARK: - Private methods
    
    private func setup(numberOfRows: Int, numberOfColumns: Int) {
        guard let collectionView = collectionView, numberOfRows != 0, numberOfColumns != 0 else {
            return
        }
        
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        
        let cellWidth = contentSize.width / CGFloat(numberOfColumns)
        let cellHeight = contentSize.height / CGFloat(numberOfRows)
        
        var xOffsets = createXOffsets(columnWidth: cellWidth, numberOfColums: numberOfColumns)
        var yOffsets = [CGFloat](repeating: sectionInset.top, count: numberOfRows)
        
        for sectionIndex in 0..<collectionView.numberOfSections {
            for itemIndex in 0..<collectionView.numberOfItems(inSection: sectionIndex) {
                let frame = CGRect(x: xOffsets[itemIndex], y: yOffsets[itemIndex], width: cellWidth, height: cellHeight)
                
                let cellSpacing: CGFloat = 0.5
                let insetFrame = frame.insetBy(dx: cellSpacing, dy: cellSpacing)
                
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                cacheItemAttributesWithFrame(insetFrame, at: indexPath)
                
                yOffsets[itemIndex] = yOffsets[itemIndex] + cellHeight
            }
        }
    }
    
    private func createXOffsets(columnWidth: CGFloat, numberOfColums: Int) -> [CGFloat] {
        var xOffset: [CGFloat] = []
        for columnNumber in 0..<numberOfColumns {
            xOffset.append(CGFloat(columnNumber) * columnWidth)
        }
        return xOffset
    }
    
    private func cacheItemAttributesWithFrame(_ frame: CGRect, at indexPath: IndexPath) {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frame
        cache[indexPath.hashValue] = attributes
    }
}
