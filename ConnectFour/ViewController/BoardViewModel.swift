//
//  BoardViewModel.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/20.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import UIKit

class BoardViewModel: NSObject, UICollectionViewDataSource {
    
    var board: Board
    let didTap: (Int) -> ()
    
    init(_ board: Board, didTap: @escaping (Int) -> ()) {
        self.board = board
        self.didTap = didTap
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.size.width * board.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ChessCell.self, indexPath: indexPath)
        let index = indexPath.row
        cell.chess = board[index]
        return cell
    }
}

extension BoardViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.frame.width
        let cellWidth = viewWidth / CGFloat(board.size.width)
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTap(indexPath.row)
    }
}
