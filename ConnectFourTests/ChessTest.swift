//
//  ChessTest.swift
//  ConnectFourTests
//
//  Created by Hsieh on 2017/11/5.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import XCTest

@testable import ConnectFour

class ChessTest: XCTestCase {
    typealias Point = (Int, Int)
    func validMove(for chess: Chess, from origional: Point ,to destination: Point, on board: Board = Board(width: 10, height: 10)) -> Bool {
        var currentBoard = board
        let ori = Position(origional.0, origional.1)
        let des = Position(destination.0, destination.1)
        let step = Step(begin: .standby(chess), end: ori, player: chess.owner)
        guard step.isValid(on: board) else { return false }
        currentBoard.move(by: step)
//        currentBoard.place(chess, on: ori)
        return chess.validMove(from: ori, to: des, on: currentBoard)
    }
    
    func testKing() {
        let king = King(owner: .red)
        XCTAssertFalse(validMove(for: king, from: (1,1), to: (2,2)))
        XCTAssertFalse(validMove(for: king, from: (1,1), to: (0,0)))
        XCTAssertFalse(validMove(for: king, from: (0,0), to: (0,-1)))
        XCTAssertTrue(validMove(for: king, from: (1,1), to: (2,1)))
        XCTAssertTrue(validMove(for: king, from: (1,1), to: (1,0)))
    }
    
    func testAssistant() {
        let assistant = Assistant(owner: .red)
        XCTAssertFalse(validMove(for: assistant, from: (1,1), to: (2,3)))
        XCTAssertFalse(validMove(for: assistant, from: (-1,9), to: (0,10)))
        XCTAssertFalse(validMove(for: assistant, from: (1,1), to: (1,2)))
        XCTAssertTrue(validMove(for: assistant, from: (1,1), to: (2,2)))
        XCTAssertTrue(validMove(for: assistant, from: (1,1), to: (2,0)))
    }
    
    func testElephant() {
        let elephant = Elephant(owner: .red)
        XCTAssertFalse(validMove(for: elephant, from: (1,4), to: (2,3)))
        XCTAssertFalse(validMove(for: elephant, from: (-1,-1), to: (1,1)))
        XCTAssertFalse(validMove(for: elephant, from: (1,1), to: (1,2)))
        XCTAssertTrue(validMove(for: elephant, from: (1,1), to: (3,3)))
        XCTAssertTrue(validMove(for: elephant, from: (2,2), to: (0,0)))
    }
    
    func testHorse() {
        let horse = Horse(owner: .red)
        XCTAssertFalse(validMove(for: horse, from: (1,4), to: (2,3)))
        XCTAssertFalse(validMove(for: horse, from: (1,10), to: (2,10)))
        XCTAssertFalse(validMove(for: horse, from: (1,1), to: (2,2)))
        XCTAssertTrue(validMove(for: horse, from: (1,1), to: (2,3)))
        XCTAssertTrue(validMove(for: horse, from: (2,2), to: (0,1)))
    }
    
    func testSolider() {
        let soldier = Soldier(owner: .red)
        XCTAssertFalse(validMove(for: soldier, from: (1,1), to: (2,2)))
        XCTAssertFalse(validMove(for: soldier, from: (1,1), to: (0,0)))
        XCTAssertFalse(validMove(for: soldier, from: (0,-1), to: (0,0)))
        XCTAssertTrue(validMove(for: soldier, from: (1,1), to: (2,1)))
        XCTAssertTrue(validMove(for: soldier, from: (1,1), to: (1,0)))
    }
    
    func testChariot() {
        let chariot = Chariot(owner: .red)
        XCTAssertFalse(validMove(for: chariot, from: (1,1), to: (2,12)))
        XCTAssertFalse(validMove(for: chariot, from: (1,1), to: (0,0)))
        XCTAssertFalse(validMove(for: chariot, from: (1,1), to: (8,7)))
        XCTAssertTrue(validMove(for: chariot, from: (1,1), to: (1,9)))
        XCTAssertTrue(validMove(for: chariot, from: (7,1), to: (2,1)))
    }
    
    func testCannon() {
        let cannon = Cannon(owner: .red)
        XCTAssertFalse(validMove(for: cannon, from: (1,1), to: (2,12)))
        XCTAssertFalse(validMove(for: cannon, from: (1,1), to: (0,0)))
        XCTAssertFalse(validMove(for: cannon, from: (1,1), to: (8,7)))
        XCTAssertTrue(validMove(for: cannon, from: (1,1), to: (1,9)))
        XCTAssertTrue(validMove(for: cannon, from: (7,1), to: (2,1)))
    }
    
    func testChariot_hasObstacle() {
        let chariot = Chariot(owner: .red)
        var newBoard = Board(width: 10, height: 10)
        
        let step1 = Step(begin: .standby(King(owner: .black)), end: Position(1,3), player: .black)
        let step2 = Step(begin: .standby(King(owner: .black)), end: Position(1,5), player: .black)
        newBoard.move(by: step1)
        newBoard.move(by: step2)
        
        XCTAssertTrue(validMove(for: chariot, from: (1,1), to: (8,1), on: newBoard))
        // Fail When BLock
        XCTAssertFalse(validMove(for: chariot, from: (1,1), to: (1,7), on: newBoard))
        XCTAssertFalse(validMove(for: chariot, from: (6,3), to: (0,3), on: newBoard))
        // Destination Occupied By Enemy
        XCTAssertTrue(validMove(for: chariot, from: (1,1), to: (1,3), on: newBoard))
        XCTAssertTrue(validMove(for: chariot, from: (8,3), to: (1,3), on: newBoard))
    }
    
    func testCannon_hasObstacle() {
        let cannon = Cannon(owner: .red)
        var newBoard = Board(width: 10, height: 10)
        
        let step1 = Step(begin: .standby(King(owner: .black)), end: Position(1,3), player: .black)
        let step2 = Step(begin: .standby(King(owner: .black)), end: Position(1,7), player: .black)
        newBoard.move(by: step1)
        newBoard.move(by: step2)

        // Destination Occupied && No Obstacle
        XCTAssertFalse(validMove(for: cannon, from: (1,1), to: (1,3), on: newBoard))
        XCTAssertFalse(validMove(for: cannon, from: (6,3), to: (1,7), on: newBoard))

        // Destination Empty && Has Obstacle
        XCTAssertFalse(validMove(for: cannon, from: (1,1), to: (1,5), on: newBoard))
        XCTAssertFalse(validMove(for: cannon, from: (6,3), to: (0,3), on: newBoard))

        // Destination Occupied && Has More Than One Obstacle
        XCTAssertFalse(validMove(for: cannon, from: (1,1), to: (1,9), on: newBoard))

        // Destination Occupied && Has One Obstacle
        XCTAssertTrue(validMove(for: cannon, from: (1,1), to: (1,7), on: newBoard))
    }
}
