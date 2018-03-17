//
//  RuleTests.swift
//  ConnectFourTests
//
//  Created by hsieh on 2017/11/6.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import XCTest

@testable import ConnectFour

class RuleTests: XCTestCase {
    
    let rules = Rules()
    
    func testHasWinner() {
        let boardA = Board(width: 10, height: 10, data: String.WinRedA.oneline)
        let boardB = Board(width: 10, height: 10, data: String.WinBlackA.oneline)
        let boardC = Board(width: 10, height: 10, data: String.WinRedB.oneline)
        let boardD = Board(width: 10, height: 10, data: String.WinBlackB.oneline)
        
        // →
        XCTAssertEqual(rules.getGameState(on: boardA), GameState.win(.red))
        // ↘
        XCTAssertEqual(rules.getGameState(on: boardB), GameState.win(.black))
        // ↓
        XCTAssertEqual(rules.getGameState(on: boardC), GameState.win(.red))
        // ↙
        XCTAssertEqual(rules.getGameState(on: boardD), GameState.win(.black))
    }
    
    func testOnGoing() {
        let boardA = Board(width: 10, height: 10, data: String.OnGoingA.oneline)
        let boardB = Board(width: 10, height: 10, data: String.OnGoingB.oneline)
        let boardC = Board(width: 10, height: 10, data: String.OnGoingC.oneline)
        let boardD = Board(width: 10, height: 10, data: String.OnGoingD.oneline)
        
        XCTAssertEqual(rules.getGameState(on: boardA), GameState.onGoing)
        XCTAssertEqual(rules.getGameState(on: boardB), GameState.onGoing)
        XCTAssertEqual(rules.getGameState(on: boardC), GameState.onGoing)
        XCTAssertEqual(rules.getGameState(on: boardD), GameState.onGoing)
    }
    
}

private extension String {
    // MARK: Board Has Winner
    static let WinRedA = """
            ----------
            -Ap-------
            --Kk------
            ---C------
            --a-R-----
            --p--P----
            --c---r---
            ----------
            ----------
            ----------
        """
    static let WinBlackA = """
            ----------
            -Ap-------
            --kk------
            --rC------
            --a-R-----
            --p--P----
            ------r---
            ----------
            ----------
            ----------
        """
    static let WinRedB = """
            ----------
            -Ap-------
            --Kk------
            ---C------
            --AARC----
            --p--P----
            --c---r---
            ----------
            ----------
            ----------
        """
    static let WinBlackB = """
            ----------
            -Ap-------
            --Kk------
            ---c-r----
            --a-r-----
            --pR-p----
            --c---r---
            ----------
            ----------
            ----------
        """
    
    // MARK: Board onGoing
    static let OnGoingA = """
            ----------
            -Ap-------
            --k-------
            --KC------
            --a-a-----
            --p--P----
            --c---C---
            ----------
            ----------
            ----------
        """
    static let OnGoingB = """
            ----------
            -Ap------p
            aa-------p
            --rC-----p
            --a-R-----
            --p--P----
            ------r---
            ----------
            ----------
            ----------
        """
    static let OnGoingC = """
            -ack------
            -Ap-------
            --Kk------
            ---c------
            --A-RCP---
            --p--P----
            -ac---r---
            p---------
            --a------k
            --p-------
        """
    static let OnGoingD = """
            c---------
            -Ap-------
            --Kk------
            ---c-r----
            --a-r-----
            --pR-p----
            --c---A---
            -------a--
            --------k-
            ---------a
        """
}
