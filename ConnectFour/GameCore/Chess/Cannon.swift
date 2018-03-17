//
//  Cannon.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct Cannon: Chess {
    let chessKind: ChessKind = .cannon
    let owner: Player
    func validPathToMove(from origional: Position, to destination: Position, on board: Board) -> Bool {
        guard Vector(from: origional, to: destination).isLinear else { return false }
        let obstacleCounts = board.linearPathStatus(from: origional, to: destination).count
        let destinationEmpty = board.isValidToPlace(on: destination)
        return destinationEmpty ? obstacleCounts == 0 : obstacleCounts == 2
    }
}
