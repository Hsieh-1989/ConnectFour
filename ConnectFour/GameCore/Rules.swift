//
//  Rules.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct Rules {
    let winLength = 4
    
    func getGameState(on board: Board) -> GameState {
        for (index, chess) in board.data {
            let position = board.position(for: index)
            if isWin(on: board, at: position, by: chess.owner) {
                return .win(chess.owner)
            }
        }
        return .onGoing
    }
    
    func isWin(on board: Board, at position: Position, by player: Player) -> Bool {
        func check(along vectorUnit: Vector.Unit) -> Bool {
            let vectorToDestination = Vector(unit: vectorUnit) * (winLength - 1)
            let destination = position.move(along: vectorToDestination)
            let pathData = board.linearPathStatus(from: position, to: destination)
            return pathData.count { $0.value.owner == player } == winLength - 1
        }
        // → ↘ ↓ ↙
        return check(along: .right) || check(along: .rightDown) || check(along: .down) || check(along: .leftDown)
    }
}
