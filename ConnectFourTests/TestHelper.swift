//
//  TestHelper.swift
//  ConnectFourTests
//
//  Created by hsieh on 2017/11/6.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation
@testable import ConnectFour

extension String {
    var oneline: String {
        return self.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
    }
}

extension GameState: Equatable {
    public static func ==(lhs: GameState, rhs: GameState) -> Bool {
        switch (lhs, rhs) {
        case (onGoing, onGoing):
            return true
        case let (win(lPlayer), win(rPlayer)):
            return lPlayer == rPlayer
        default:
            return false
        }
    }
}
