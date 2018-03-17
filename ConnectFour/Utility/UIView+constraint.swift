//
//  UIView+constraint.swift
//  ConnectFour
//
//  Created by Hsieh on 2017/11/18.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import UIKit

extension UIView {
    func constraintEqual(to other: UIView, margin: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: margin),
            self.trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: margin),
            self.topAnchor.constraint(equalTo: other.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: margin),
        ])
    }
}

extension CGRect {
    func shrink(ratio: CGFloat) -> CGRect {
        let diffWidth = self.width - self.width * ratio
        let diffHeight = self.height - self.height * ratio
        return CGRect(
            x: self.origin.x + diffWidth / 2.0,
            y: self.origin.y + diffHeight / 2.0,
            width: self.width * ratio,
            height: self.height * ratio)
    }
}
