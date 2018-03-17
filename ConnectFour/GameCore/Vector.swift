//
//  Vector.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

struct Vector {
    let x: Int
    let y: Int
    
    // vertical or horizontal
    var isLinear: Bool {
        return self.x == 0 || self.y == 0
    }
    
    var unit: Vector? {
        let newX = x > 0 ? 1 : -1
        let newY = y > 0 ? 1 : -1
        switch (x,y) {
        case (0, 0): return nil
        case (_, 0): return Vector(x: newX, y: 0)
        case (0, _): return Vector(x: 0, y: newY)
        default:
            guard x.magnitude == y.magnitude else { return nil }
            return Vector(x: newX, y: newY)
        }
    }
}

extension Vector {
    static func *(_ l: Vector, _ r: Int) -> Vector {
        return Vector(x: l.x * r, y: l.y * r)
    }
}

extension Vector {
    init(from origional: Position, to destination: Position) {
        self.x = destination.x - origional.x
        self.y = destination.y - origional.y
    }
}

extension Vector {
    enum Unit {
        case right
        case left
        case down
        case top
        case rightDown
        case rightTop
        case leftDown
        case leftTop
    }
    
    init(unit: Unit) {
        switch unit {
        case .right:
            self.init(x: 1, y: 0)
        case .left:
            self.init(x: -1, y: 0)
        case .down:
            self.init(x: 0, y: 1)
        case .top:
            self.init(x: 0, y: -1)
        case .rightDown:
            self.init(x: 1, y: 1)
        case .rightTop:
            self.init(x: 1, y: -1)
        case .leftDown:
            self.init(x: -1, y: 1)
        case .leftTop:
            self.init(x: -1, y: -1)
        }
    }
}
