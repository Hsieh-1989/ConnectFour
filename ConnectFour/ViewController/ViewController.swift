//
//  ViewController.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var boardView: UICollectionView!
    @IBOutlet weak var standbyView: UICollectionView!
    
    //MARK: Property
    var game = Game(board: Board(width: 8, height: 8)) {
        didSet {
            updateGameState()
        }
    }
    
    //MARK: Private Property
    //FIXME: should have better way to handle selected state
    private enum StepBegin {
        case none
        case board(Int)
        case standby(Int)
    }
    private var stepBegin: StepBegin = .none
    
    private lazy var standbyVM: StandbyViewModel = {
        return StandbyViewModel(chesses: game.standbyChessRed, player: game.currentPlayer) { [unowned self] index in
            self.setStepBeginStandby(index: index)
        }
    }()
    
    private lazy var boardVM: BoardViewModel = {
        return BoardViewModel(game.board) { [unowned self] index in
            switch self.stepBegin {
            case .none:
                self.setStepBeginBoard(index: index)
            case .board(let previous), .standby(let previous):
                self.tryMove(index: index)
            }
        }
    }()
    
    private var currentStatusText: String {
        switch game.state {
        case .onGoing:
            return "CURRENT PLAYER : \" \(game.currentPlayer.rawValue.uppercased())\""
        case .win(let player):
            return "WIN : \"\(player.rawValue)\""
        }
    }
    
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = currentStatusText
        setupCollectionView()
    }
    
    //MARK: IBAction
    @IBAction func reStart(_ sender: Any) {
        game = Game(board: Board(width: 8, height: 8))
    }
    
    //MARK: Private Method
    private func setupCollectionView() {
        boardView.register(ChessCell.self, forCellWithReuseIdentifier: "ChessCell")
        boardView.dataSource = boardVM
        boardView.delegate = boardVM
        
        standbyView.register(ChessCell.self, forCellWithReuseIdentifier: "ChessCell")
        standbyView.dataSource =  standbyVM
        standbyView.delegate = standbyVM
    }

    private func tryMove(index: Int) {
        guard let begin = getStepBegin() else {
            setStepBeginBoard(index: index)
            return
        }
        let destination = game.board.position(for: index)
        game.move(start: begin, end: destination) { [weak self] result in
            switch result {
            case .success(_):
                self?.updateGameState()
            case .error(_):
                self?.setStepBeginBoard(index: index)
            }
        }
        
    }
    
    private func getStepBegin() -> Step.Begin? {
        switch self.stepBegin {
        case .none:
            return nil
        case .standby(let index):
            let chess = game.currentStandby[index].getChess(player: game.currentPlayer)
            return .standby(chess)
        case .board(let previous):
            let beginPosition = game.board.position(for: previous)
            return .board(beginPosition)
        }
    }
    
    private func setStepBeginStandby(index: Int) {
        if case let .standby(previous) = stepBegin, previous == index {
            stepBegin = .none
        } else {
            stepBegin = .standby(index)
        }
    }
    
    private func setStepBeginBoard(index: Int) {
        if case let .board(previous) = stepBegin, previous == index {
            stepBegin = .none
        } else {
            stepBegin = .board(index)
        }
    }
    
    private func updateGameState() {
        stepBegin = .none
        statusLabel.text = currentStatusText
        boardVM.board = game.board
        standbyVM.turn(chesses: game.currentStandby, player: game.currentPlayer)
        boardView.reloadData()
        standbyView.reloadData()
    }
}
