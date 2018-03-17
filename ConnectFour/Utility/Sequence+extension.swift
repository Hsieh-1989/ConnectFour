//
//  Sequence+extension.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/2.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import Foundation

extension Sequence {
    func count(where predicate: (Element) -> Bool) -> Int {
        var total = 0
        for element in self {
            total += predicate(element) ? 1 : 0
        }
        return total
    }
    
    func all(where predicate: (Element) -> Bool) -> Bool {
        for element in self {
            if !predicate(element) {
                return false
            }
        }
        return true
    }
    
    func none(where predicate: (Element) -> Bool) -> Bool {
        for element in self {
            if predicate(element) {
                return false
            }
        }
        return true
    }
    func enumeratedToDictionary<T>(transform: (Element) -> T?) -> [Int: T] {
        var result: [Int: T] = [:]
        for (i, value) in self.enumerated() {
            guard let newValue = transform(value) else { continue }
            result[i] = newValue
        }
        return result
    }
}

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
    func unique() -> [Element] {
        var tmp: [Element] = []
        for i in 0..<self.count {
            let element = self[i]
            if !tmp.contains(element) {
                tmp.append(element)
            }
        }
        return tmp
    }
}
