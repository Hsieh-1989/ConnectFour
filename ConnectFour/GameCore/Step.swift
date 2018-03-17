//
//  Step.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/16.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct Step {
    enum Begin {
        case board(Position)
        case standby(Chess)
    }
    let begin: Begin
    let end: Position
    let player: Player
}
