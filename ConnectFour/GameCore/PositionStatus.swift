//
//  PositionStatus.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/17.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct PositionStatus {
    enum State {
        case empty
        case occupied(Chess)
    }
    let state: State
    let position: Position
}
