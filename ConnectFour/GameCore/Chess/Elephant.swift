//
//  Elephant.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct Elephant: Chess {
    let chessKind: ChessKind = .elephant
    let owner: Player
    func validPathToMove(from origional: Position, to destination: Position, on board: Board) -> Bool {
        let vector = Vector(from: origional, to: destination)
        return vector.x.magnitude == 2 && vector.y.magnitude == 2
    }
}
