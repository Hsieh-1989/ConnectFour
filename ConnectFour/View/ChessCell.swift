//
//  ChessCell.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/20.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import UIKit

class ChessCell: UICollectionViewCell {
    //MARK: Property
    var chess: Chess? {
        didSet {
            setNeedsDisplay()
            update(text: character)
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clearsContextBeforeDrawing = true
        self.backgroundColor = UIColor.clear
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public Method
    func configure(chess: Chess){
        self.chess = chess
        update(text: character)
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.shrink(ratio: circleRatio))
        if chess == nil {
            color.setFill()
            circlePath.fill()
        } else {
            color.setStroke()
            circlePath.lineWidth = self.frame.width / 15.0 * circleRatio
            circlePath.stroke()
        }
    }
    
    //MARK: Private Method - update UI
    private func setupLabel() {
        contentView.addSubview(label)
        label.constraintEqual(to: contentView)
    }
    private func update(text: String) {
        label.textColor = color
        label.text = character
    }
    
    //MARK: Private Property
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = labelFont
        label.textColor = color
        return label
    }()
    
    private var labelFont: UIFont {
        let fontSize = frame.width * 0.5
        return UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private var color: UIColor {
        return chess?.owner.coloer ?? UIColor.lightGray
    }
    
    private var character: String {
        return chess?.name ?? ""
    }
    
    private var circleRatio: CGFloat {
        return chess == nil ? 0.1 : 0.75
    }
    
}
