//
//  Result.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/6.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

enum Result<Value, ErrorType: Error> {
    case success(Value)
    case error(ErrorType)
}

extension Result where Value: Equatable, ErrorType: Equatable {
    static func ==(lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case let (.success(l), .success(r)):
            return l == r
        case let (.error(l), .error(r)):
            return l == r
        default:
            return false
        }
    }
}


enum GameError: Error {
//    case inValidPosition(Position)
//    case inValidOwner(Player)
//    case noChessToMove
    case inValidMove
}
