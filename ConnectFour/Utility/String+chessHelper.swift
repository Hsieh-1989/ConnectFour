//
//  String+ChessHelper.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/6.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

extension String {
    
    func parseBoard() -> BoardData {
        return self.enumeratedToDictionary { String($0).getChess() }
    }
    
    //FIXME: kind of stupid
    private func getChess() -> Chess? {
        switch self {
        case ChessString.Red.Code.King: return King(owner: .red)
        case ChessString.Red.Code.Assistant: return Assistant(owner: .red)
        case ChessString.Red.Code.Elephant: return Elephant(owner: .red)
        case ChessString.Red.Code.Horse: return Horse(owner: .red)
        case ChessString.Red.Code.Chariot: return Chariot(owner: .red)
        case ChessString.Red.Code.Cannon: return Cannon(owner: .red)
        case ChessString.Red.Code.Soldier: return Soldier(owner: .red)
        case ChessString.Black.Code.King: return King(owner: .black)
        case ChessString.Black.Code.Assistant: return Assistant(owner: .black)
        case ChessString.Black.Code.Elephant: return Elephant(owner: .black)
        case ChessString.Black.Code.Horse: return Horse(owner: .black)
        case ChessString.Black.Code.Chariot: return Chariot(owner: .black)
        case ChessString.Black.Code.Cannon: return Cannon(owner: .black)
        case ChessString.Black.Code.Soldier: return Soldier(owner: .black)
        default: return nil
        }
    }
}
