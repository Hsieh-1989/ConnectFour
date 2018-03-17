//
//  King.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct King: Chess {
    let chessKind: ChessKind = .king
    let owner: Player
    func validPathToMove(from origional: Position, to destination: Position, on board: Board) -> Bool {
        let vector = Vector(from: origional, to: destination)
        return vector.isLinear && (vector.x.magnitude == 1 || vector.y.magnitude == 1)
    }
}
