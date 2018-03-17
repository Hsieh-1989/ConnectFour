//
//  StandbyViewModel.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/20.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import UIKit

class StandbyViewModel: NSObject, UICollectionViewDataSource {
    
    var chesses: [ChessKind]
    var player: Player
    let didTap: (Int) -> ()
    
    init(chesses: [ChessKind], player: Player, didTap: @escaping (Int) -> ()) {
        self.chesses = chesses
        self.player = player
        self.didTap = didTap
    }
    
    func turn(chesses: [ChessKind], player: Player) {
        self.chesses = chesses
        self.player = player
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chesses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ChessCell.self, indexPath: indexPath)
        let index = indexPath.row
        let chess = chesses[index].getChess(player: player)
        cell.chess = chess
        return cell
    }
}

extension StandbyViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTap(indexPath.row)
    }
}
