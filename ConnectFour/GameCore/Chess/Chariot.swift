//
//  Chariot.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct Chariot: Chess {
    let chessKind: ChessKind = .chariot
    let owner: Player
    func validPathToMove(from origional: Position, to destination: Position, on board: Board) -> Bool {
        let vector = Vector(from: origional, to: destination)
        guard vector.isLinear else { return false }
        return board.linearPathStatus(from: origional, to: destination).none {
            return board.position(for: $0.key) != destination
        }
    }
}
