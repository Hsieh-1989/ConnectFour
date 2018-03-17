//
//  Player.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import UIKit

enum Player: String {
    case red
    case black
    
    var turn: Player {
        return self == .red ? .black : .red
    }
    
    var coloer: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .black:
            return UIColor.black
        }
    }
}
