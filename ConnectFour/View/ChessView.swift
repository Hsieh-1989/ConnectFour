//
//  ChessView.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/17.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import UIKit

final class ChessView: UIView {
    typealias clickOnBoard = (PositionStatus) -> ()
    
    //MARK: Property
    let didTap: clickOnBoard
    var positionStatus: PositionStatus {
        didSet {
            setNeedsDisplay()
            updateButton(text: text)
        }
    }
    
    //MARK: Initialize
    init(frame: CGRect, status: PositionStatus, didTap: @escaping clickOnBoard ) {
        self.positionStatus = status
        self.didTap = didTap
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.shrink(ratio: circleRatio))
        color.setStroke()
        circlePath.lineWidth = self.frame.width / 18.0 * circleRatio
        circlePath.stroke()
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        didTap(positionStatus)
    }
    
    //MARK: Private Property
    private let button = UIButton(type: .custom)
    
    private var font: UIFont {
        let fontSize = frame.width * 0.6
        return UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private var color: UIColor {
        switch positionStatus.state {
        case .empty: return UIColor.cyan
        case .occupied(let chess): return chess.owner.coloer
        }
    }
    
    private var text: String {
        switch positionStatus.state {
        case .empty: return ""
        case .occupied(let chess): return chess.name
        }
    }
    
    private var circleRatio: CGFloat {
        switch positionStatus.state {
        case .empty: return 0.4
        case .occupied: return 0.9
        }
    }
    
    //MARK: Private Method - UI
    private func setup() {
        self.clearsContextBeforeDrawing = true
        self.backgroundColor = UIColor.white
        setupButton()
    }
    
    private func setupButton() {
        button.titleLabel?.font = font
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.constraintEqual(to: self)
        updateButton(text: text)
    }
    
    private func updateButton(text: String) {
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
    }
}
