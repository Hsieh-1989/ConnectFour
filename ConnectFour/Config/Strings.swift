//
//  Strings.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/5.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

enum ChessString {
    //FIXME: Does it need to be a nested enum?
    enum Red {
        enum Code {
            static let King = "K"
            static let Assistant = "A"
            static let Elephant = "E"
            static let Horse = "H"
            static let Chariot = "R"
            static let Cannon = "C"
            static let Soldier = "P"
        }
        
        enum Name {
            static let King = "帥"
            static let Assistant = "仕"
            static let Elephant = "相"
            static let Horse = "傌"
            static let Chariot = "俥"
            static let Cannon = "炮"
            static let Soldier = "兵"
        }
    }
    
    enum Black {
        enum Code {
            static let King = "k"
            static let Assistant = "a"
            static let Elephant = "e"
            static let Horse = "h"
            static let Chariot = "r"
            static let Cannon = "c"
            static let Soldier = "p"
        }
        
        enum Name {
            static let King = "將"
            static let Assistant = "士"
            static let Elephant = "象"
            static let Horse = "馬"
            static let Chariot = "車"
            static let Cannon = "包"
            static let Soldier = "卒"
        }
    }
}
