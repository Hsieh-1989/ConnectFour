//
//  Game.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/17.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

final class Game {
    //MARK: Property
    var state: GameState
    var currentPlayer: Player
    var board: Board
    var standbyChessRed: [ChessKind]
    var standbyChessBlack: [ChessKind]
    let rules = Rules()
    
    var currentStandby: [ChessKind] {
        switch currentPlayer {
        case .red:
            return standbyChessRed
        case .black:
            return standbyChessBlack
        }
    }
    
    //MARK: Initialization
    init(state: GameState = .onGoing,
         currentPlayer: Player = .red,
         board: Board,
         reds: [ChessKind] = ChessKind.basicSet,
         blacks: [ChessKind] = ChessKind.basicSet) {
        
        self.state = state
        self.board = board
        self.standbyChessRed = reds
        self.standbyChessBlack = blacks
        self.currentPlayer = currentPlayer
    }
    
    func move(start type: Step.Begin, end: Position, complete: ((Result<GameState, GameError>) -> Void)?)  {
        let step = Step(begin: type, end: end, player: currentPlayer)
        guard step.isValid(on: board) else {
            complete?(.error(.inValidMove))
            return
        }
        board.move(by: step)
        currentPlayer = currentPlayer.turn
        let newState = rules.getGameState(on: board)
        state = newState
        complete?(.success(state))
    }
}

extension Game: CustomStringConvertible {
    var description: String {
        return """
        \(board)
        ---------
        RED  : \(standbyChessRed)
        BLACK: \(standbyChessBlack)
        """
    }
}

extension ChessKind {
    fileprivate static let basicSet: [ChessKind] = [
        king,
        assistant, assistant,
        elephant, elephant,
        horse, horse,
        chariot, chariot,
        cannon, cannon,
        soldier, soldier, soldier, soldier, soldier
    ]
}
