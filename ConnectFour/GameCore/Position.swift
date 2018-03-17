//
//  Position.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct Position {
    let x: Int
    let y: Int
}

extension Position {
    static let zero = Position(0, 0)
    init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y)
    }
}

extension Position {
    func move(along vector: Vector) -> Position {
        return Position(x + vector.x, y + vector.y)
    }
}

extension Position: Equatable {
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}


