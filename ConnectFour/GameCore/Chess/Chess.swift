//
//  Chess.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

enum ChessKind {
    case king
    case assistant
    case elephant
    case chariot
    case horse
    case cannon
    case soldier
}

extension ChessKind {
    func getChess(player: Player) -> Chess {
        switch self {
        case .king:
            return King(owner: player)
        case .assistant:
            return Assistant(owner: player)
        case .elephant:
            return Elephant(owner: player)
        case .chariot:
            return Chariot(owner: player)
        case .horse:
            return Horse(owner: player)
        case .cannon:
            return Cannon(owner: player)
        case .soldier:
            return Soldier(owner: player)
        }
    }
}

protocol Chess {
    var chessKind: ChessKind { get }
    var owner: Player { get }
    func validPathToMove(from origional: Position, to destination: Position, on board: Board) -> Bool
}

extension Chess {
    func validMove(from origional: Position, to destination: Position, on board: Board) -> Bool {
        guard board.isValidToMove(to: destination, for: self.owner) else { return false }
        return validPathToMove(from: origional, to: destination, on: board)
    }
}

extension Chess {
    func isEqual(_ chess: Chess) -> Bool {
        return self.chessKind == chess.chessKind && self.owner == chess.owner
    }
}

extension Chess {
    var name: String {
        switch owner {
        case .red:
            return self.redName
        case .black:
            return self.blackName
        }
    }
    
    var code: String {
        switch owner {
        case .red:
            return self.redName
        case .black:
            return self.blackName
        }
    }
    
    private var redName: String{
        switch chessKind {
        case .king: return ChessString.Red.Name.King
        case .assistant:  return ChessString.Red.Name.Assistant
        case .elephant:  return ChessString.Red.Name.Elephant
        case .chariot:  return ChessString.Red.Name.Chariot
        case .horse:  return ChessString.Red.Name.Horse
        case .cannon:  return ChessString.Red.Name.Cannon
        case .soldier: return ChessString.Red.Name.Soldier
        }
    }
    
    private var blackName: String{
        switch chessKind {
        case .king: return ChessString.Black.Name.King
        case .assistant:  return ChessString.Black.Name.Assistant
        case .elephant:  return ChessString.Black.Name.Elephant
        case .chariot:  return ChessString.Black.Name.Chariot
        case .horse:  return ChessString.Black.Name.Horse
        case .cannon:  return ChessString.Black.Name.Cannon
        case .soldier: return ChessString.Black.Name.Soldier
        }
    }
    
    private var redCode: String {
        switch chessKind {
        case .king: return ChessString.Red.Code.King
        case .assistant:  return ChessString.Red.Code.Assistant
        case .elephant:  return ChessString.Red.Code.Elephant
        case .chariot:  return ChessString.Red.Code.Chariot
        case .horse:  return ChessString.Red.Code.Horse
        case .cannon:  return ChessString.Red.Code.Cannon
        case .soldier: return ChessString.Red.Code.Soldier
        }
    }
    
    private var blackCode: String{
        switch chessKind {
        case .king: return ChessString.Black.Code.King
        case .assistant:  return ChessString.Black.Code.Assistant
        case .elephant:  return ChessString.Black.Code.Elephant
        case .chariot:  return ChessString.Black.Code.Chariot
        case .horse:  return ChessString.Black.Code.Horse
        case .cannon:  return ChessString.Black.Code.Cannon
        case .soldier: return ChessString.Black.Code.Soldier
        }
    }
}
