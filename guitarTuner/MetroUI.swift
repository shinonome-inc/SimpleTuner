//
//  MetroCountView.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/26.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class MetroCountView: UIView {
    
    private let circle1 = CircleLayer()
    private let circle2 = CircleLayer()
    private let circle3 = CircleLayer()
    private let circle4 = CircleLayer()
    private let circle5 = CircleLayer()
    private let circle6 = CircleLayer()
    
    var beatNumber = 4
    
    func makeView() {
        let xCenter = self.frame.width * 0.5
        let height = self.frame.height
        let materWidth = self.frame.width * 0.8
        let space = materWidth / CGFloat(beatNumber - 1)
        let diameter = xCenter * 0.1
        let radious = diameter * 0.5
        var leftSide = self.frame.width * 0.1 - radious
        let circles = [circle1, circle2, circle3, circle4, circle5, circle6]
        
        for i in 0 ..< beatNumber {
            let circle = circles[i]
            circle.path = UIBezierPath(ovalIn: CGRect.init(x: leftSide, y: height, width: diameter, height: diameter)).cgPath
            circle.drawCircle(frame: self.frame)
            self.layer.addSublayer(circle)
            leftSide = leftSide + space
           }
    }
    
    func circleLighting(beatCount: Int) {
        let circles = [circle1, circle2, circle3, circle4, circle5, circle6]
        for i in 0 ..< beatCount - 1 {
            let circle = circles[i]
            circle.lightOff()
        }
        if beatCount == 1 {
            circles[beatNumber - 1].lightOff()
        }
        let circle = circles[beatCount - 1]
        circle.lighting()
    }
    
    func refresh() {
        let circles = [circle1, circle2, circle3, circle4, circle5, circle6]
        for i in 0 ..< beatNumber {
            circles[i].lightOff()
        }
    }
}

class numberPadView: UIView {
    private let button1 = UIButton()
    private let button2 = UIButton()
    private let button3 = UIButton()
    private let button4 = UIButton()
    private let button5 = UIButton()
    private let button6 = UIButton()
    private let button7 = UIButton()
    private let button8 = UIButton()
    private let button9 = UIButton()
    private let button0 = UIButton()
    private let buttonCL = UIButton()
    private let buttonSET = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = self.frame.width
        let height = self.frame.height
        let leftSide = width * 0.3
        let space = width * 0.1
        let numberButtons = [button1, button2, button3, button4, button5, button6, button7, button8, button9]
        for (index, numberButton) in numberButtons.enumerated() {
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
