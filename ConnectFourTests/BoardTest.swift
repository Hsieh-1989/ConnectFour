//
//  BoardTest.swift
//  ConnectFourTests
//
//  Created by hsieh on 2017/11/6.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import XCTest

@testable import ConnectFour

class BoardTest: XCTestCase {
    let RKing = King(owner: .red)
    let RChariot = Chariot(owner: .red)
    let BCannon = Cannon(owner: .black)
    let BHorse = Horse(owner: .black)
    func testPlace() {
        var boardA = Board(width: 10, height: 10, data: String.OnGoingA.oneline)
        let stepA = Step(begin: .standby(RKing), end: Position(1,0), player: .red)
        boardA.move(by: stepA)
        let expectedBoardA = Board(width: 10, height: 10, data: String.ExpectedA.oneline)
        XCTAssertEqual(boardA, expectedBoardA)
        
        var boardB = Board(width: 10, height: 10, data: String.OnGoingB.oneline)
        let stepB = Step(begin: .standby(RChariot), end: Position(9,9), player: .red)
        boardB.move(by: stepB)
        let expectedBoardB = Board(width: 10, height: 10, data: String.ExpectedB.oneline)
        XCTAssertEqual(boardB, expectedBoardB)
        
        var boardC = Board(width: 10, height: 10, data: String.OnGoingC.oneline)
        let stepC = Step(begin: .standby(BHorse), end: Position(4,3), player: .black)
        boardC.move(by: stepC)
        let expectedBoardC = Board(width: 10, height: 10, data: String.ExpectedC.oneline)
        XCTAssertEqual(boardC, expectedBoardC)
    }
    
    func testOccupiedPlace() {
        var boardA = Board(width: 10, height: 10, data: String.OnGoingA.oneline)
        let stepA = Step(begin: .standby(RKing), end: Position.zero, player: .red)
        if stepA.isValid(on: boardA) {
            boardA.move(by: stepA)
        }
        let expectedBoardA = Board(width: 10, height: 10, data: String.OnGoingA.oneline)
        XCTAssertEqual(boardA, expectedBoardA)

        var boardB = Board(width: 10, height: 10, data: String.OnGoingB.oneline)
        let stepB = Step(begin: .standby(RKing), end: Position(1,1), player: .red)
        if stepB.isValid(on: boardB) {
            boardB.move(by: stepB)
        }
        let expectedBoardB = Board(width: 10, height: 10, data: String.OnGoingB.oneline)
        XCTAssertEqual(boardB, expectedBoardB)

        var boardC = Board(width: 10, height: 10, data: String.OnGoingC.oneline)
        let stepC = Step(begin: .standby(RKing), end: Position(5,5), player: .red)
        if stepC.isValid(on: boardC) {
            boardC.move(by: stepC)
        }
        let expectedBoardC = Board(width: 10, height: 10, data: String.OnGoingC.oneline)
        XCTAssertEqual(boardC, expectedBoardC)
    }
    
    func testMove() {
        var boardA = Board(width: 10, height: 10, data: String.OnGoingA.oneline)
        let stepA = Step(begin: .board(Position.zero), end: Position(1,0), player: .red)
        boardA.move(by: stepA)
        let expectedBoardA = Board(width: 10, height: 10, data: String.MoveA.oneline)
        XCTAssertEqual(boardA, expectedBoardA)
        
        var boardB = Board(width: 10, height: 10, data: String.OnGoingB.oneline)
        let stepB = Step(begin: .board(Position(4,4)), end: Position(4,9), player: .red)
        boardB.move(by: stepB)
        let expectedBoardB = Board(width: 10, height: 10, data: String.MoveB.oneline)
        XCTAssertEqual(boardB, expectedBoardB)
        
        var boardC = Board(width: 10, height: 10, data: String.OnGoingC.oneline)
        let stepC = Step(begin: .board(Position(2,6)), end: Position(2,4), player: .black)
        boardC.move(by: stepC)
        let expectedBoardC = Board(width: 10, height: 10, data: String.MoveC.oneline)
        XCTAssertEqual(boardC, expectedBoardC)
    }

    
    func testInvalidMove() {
        // move position empty
        var boardA = Board(width: 10, height: 10, data: String.OnGoingA.oneline)
        let stepA = Step(begin: .board(Position(1,0)), end: Position(1,1), player: .red)
        if stepA.isValid(on: boardA) {
            boardA.move(by: stepA)
        }
        let expectedBoardA = Board(width: 10, height: 10, data: String.OnGoingA.oneline)
        XCTAssertEqual(boardA, expectedBoardA)
        
        // move enemy chess
        var boardB = Board(width: 10, height: 10, data: String.OnGoingB.oneline)
        let stepB = Step(begin: .board(Position(4,4)), end: Position(4,9), player: .black)
        if stepB.isValid(on: boardB) {
            boardB.move(by: stepB)
        }
        let expectedBoardB = Board(width: 10, height: 10, data: String.OnGoingB.oneline)
        XCTAssertEqual(boardB, expectedBoardB)
        
        // invalid path
        var boardC = Board(width: 10, height: 10, data: String.OnGoingC.oneline)
        let stepC = Step(begin: .board(Position(2,6)), end: Position(2,2), player: .red)
        if stepC.isValid(on: boardC) {
            boardC.move(by: stepC)
        }
        let expectedBoardC = Board(width: 10, height: 10, data: String.OnGoingC.oneline)
        XCTAssertEqual(boardC, expectedBoardC)
    }
}

private extension String {
    // MARK: Board onGoing
    static let OnGoingA = """
            K---------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
        """
    static let MoveA = """
            -K--------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
        """
    static let ExpectedA = """
            KK--------
            ----------
            ----------
            ----------
            ----------
            ----------
            ----------
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
    static let MoveB = """
            ----------
            -Ap------p
            aa-------p
            --rC-----p
            --a-------
            --p--P----
            ------r---
            ----------
            ----------
            ----R-----
        """
    static let ExpectedB = """
            ----------
            -Ap------p
            aa-------p
            --rC-----p
            --a-R-----
            --p--P----
            ------r---
            ----------
            ----------
            ---------R
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
    static let MoveC = """
            -ack------
            -Ap-------
            --Kk------
            ---c------
            --c-RCP---
            --p--P----
            -a----r---
            p---------
            --a------k
            --p-------
        """
    static let ExpectedC = """
            -ack------
            -Ap-------
            --Kk------
            ---ch-----
            --A-RCP---
            --p--P----
            -ac---r---
            p---------
            --a------k
            --p-------
        """
}

// MARK: Test Helper Method
func errorCase(_ result: Result<Chess, GameError>, expectedError: GameError) {
    switch result {
    case .success(_):
        XCTAssertFalse(true)
    case let .error(error):
        XCTAssertEqual(error, expectedError)
    }
}

func successCase(_ result: Result<Chess, GameError>, expectedChess: Chess) {
    switch result {
    case let .success(chess):
        XCTAssertTrue(chess.isEqual(expectedChess))
    case .error(_):
        XCTAssertFalse(true)
    }
}

