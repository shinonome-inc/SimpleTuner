//
//  underLineView.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2021/02/05.
//  Copyright © 2021 大谷悦志. All rights reserved.
//

import UIKit

class UnderLineView: UIView {
    
    let line = CALayer()
    let lineWidth: CGFloat = 2
    var lineColor: UIColor = UIColor.clear {
        didSet {
            line.backgroundColor = lineColor.cgColor
        }
    }
    
    func drawUnderLine() {
        line.frame = CGRect(x: 0.0, y: (self.frame.size.height) - lineWidth, width: (self.frame.size.width), height: lineWidth)
        self.layer.addSublayer(line)
    }
}
