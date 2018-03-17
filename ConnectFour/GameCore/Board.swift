//
//  Board.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

typealias BoardData = [Int: Chess]

struct Board {
    struct BoardSize {
        let width: Int
        let height : Int
    }
    let size: BoardSize
    var data: BoardData
    
    init(width: Int, height: Int, data: BoardData = [:]) {
        self.size = BoardSize(width: width, height: height)
        self.data = data
    }
    
    func position(for index: Int) -> Position {
        guard index > 0 else { return Position.zero }
        let x = index % size.width
        let y = index / size.width
        return Position(x, y)
    }
    
    mutating func move(by step: Step) {
        switch step.begin {
        case .board(let origional):
            self[step.end] = self[origional]
            self[origional] = nil
        case .standby(let chess):
            self[step.end] = chess
        }
    }
    
    private func index(on position: Position) -> Int {
        return position.x + position.y * size.width
    }
    
    private func isValid(on position: Position) -> Bool {
        return position.x >= 0 && position.x < size.width && position.y >= 0 && position.y  < size.height
    }
    
    // MARK: Subscript
    subscript(_ index: Int) -> Chess? {
        get {
            return data[index]
        }
    }
    fileprivate subscript(_ position: Position) -> Chess? {
        get {
            return data[index(on: position)]
        }
        set(newValue) {
            guard isValid(on: position) else { return }
            data[index(on: position)] = newValue
        }
    }
}

extension Board {
    // position is on the board and empty
    func isValidToPlace(on position: Position) -> Bool {
        guard isValid(on: position) else { return false }
        return self[position] == nil
    }
    
    // destination is empty or occupeid by enemy
    func isValidToMove(to destination: Position, for player: Player) -> Bool {
        guard isValid(on: destination) else { return false }
        if let occupiedChess = self[destination] {
            return occupiedChess.owner != player
        }
        return true
    }
    
    func linearPathStatus(from origional: Position, to destination: Position) -> BoardData {
        guard isValid(on: origional), isValid(on: destination), let vector = Vector(from: origional, to: destination).unit else { return [:] }
        var data: BoardData = [:]
        let end = destination.move(along: vector)
        func appendStatus(_ position: Position) {
            guard position != end else { return }
            if let chess = self[position] {
                data[index(on: position)] = chess
            }
            appendStatus(position.move(along: vector))
        }
        appendStatus(origional.move(along: vector))
        return data
    }
}

extension Board: Equatable {
    static func ==(lhs: Board, rhs: Board) -> Bool {
        return lhs.size.width == rhs.size.width &&
            lhs.size.height == rhs.size.height &&
            lhs.data.count == rhs.data.count &&
            lhs.data.all {
                guard let rChess = rhs.data[$0.key] else { return false }
                return $0.value.isEqual(rChess)
        }
    }
}

// MARK: Board Init with String
extension Board {
    init(width: Int, height: Int, data: String) {
        self.init(width: width, height: height)
        self.data = data.parseBoard()
    }
}

extension Board: CustomStringConvertible {
    var description: String {
        var result = ""
        for y in 0..<size.height {
            for x in 0..<size.width {
                let position = Position(x,y)
                guard let chess = self[position] else {
                    result += "＋"
                    continue
                }
                result += chess.name
            }
            result += "\n"
        }
        return result
    }
}

// MARK: Check Vaildation Step on Board
extension Step {
    func isValid(on board: Board) -> Bool {
        switch begin {
        case .board(let position):
            guard let chess = board[position], chess.owner == player else { return false }
            return chess.validMove(from: position, to: end, on: board)
            
        case .standby(let chess):
            return chess.owner == player && board.isValidToPlace(on: end)
        }
    }
}
