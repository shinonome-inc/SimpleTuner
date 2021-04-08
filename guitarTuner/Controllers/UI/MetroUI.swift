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
    var color: ThemeColor = .blue
    
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
        circle.lighting(color: color)
    }
    
    func refresh() {
        let circles = [circle1, circle2, circle3, circle4, circle5, circle6]
        for i in 0 ..< beatNumber {
            circles[i].lightOff()
        }
    }
}

protocol NumberPadViewDelegate: class {
    func numberButtonTapped(number: String)
    func CLButtonTapped()
    func SETButtonTapped()
}

class NumberPadView: UIView {
    
    weak var delegate: NumberPadViewDelegate?
    
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
    
    var firstTouch: Bool = true
    
    func makeView() {
        let width = frame.width
        let spaceY = width * 0.2
        let topEnd = width * 0.1
        let buttons = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button0, buttonCL, buttonSET]
        for (index, button) in buttons.enumerated() {
            button.tag = index + 1
            switch index / 3 {
            case 0:
                buttonDetail(index: index, y: topEnd, button: button, frame: frame)
            case 1:
                buttonDetail(index: index, y: topEnd + spaceY, button: button, frame: frame)
            case 2:
                buttonDetail(index: index, y: topEnd + (spaceY * 2), button: button, frame: frame)
            case 3:
                otherButtonDetail(index: index, y: topEnd + (spaceY * 3), button: button, frame: frame)
            default:
                return
            }
            self.addSubview(button)
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        }
        self.backgroundColor = UIColor.mainBackground
    }
    
    func buttonDetail(index: Int, y: CGFloat, button: UIButton, frame: CGRect) {
        let width = frame.width
        let leftSide = width * 0.15
        let spaceX = width * 0.05
        let buttonWidth = width * 0.2
        let x: CGFloat
        
        switch index % 3 {
        case 0:
            x = leftSide
        case 1:
            x = leftSide + buttonWidth + spaceX
        case 2:
            x = leftSide + buttonWidth * 2 + spaceX * 2
        default:
            return
        }
        button.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonWidth)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = buttonWidth * 0.5
        button.layer.borderWidth = 1.0
        button.setTitle(String(index + 1), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
    }
    
    func otherButtonDetail(index: Int, y: CGFloat, button: UIButton, frame: CGRect) {
        let width = frame.width
        let leftSide = width * 0.15
        let spaceX = width * 0.05
        let spaceY = width * 0.2
        let buttonHeight = width * 0.2
        let buttonWidth: CGFloat
        let x: CGFloat
        var y = y
        
        switch index % 3 {
        case 0:
            x = leftSide
            buttonWidth = width * 0.45
            button.setTitle("0", for: .normal)
        case 1:
            buttonWidth = width * 0.2
            x = leftSide + buttonWidth * 2 + spaceX * 2
            button.setTitle("CL", for: .normal)
        case 2:
            x = leftSide
            y = y + spaceY
            buttonWidth = width * 0.7
            button.setTitle("SET", for: .normal)
        default:
            return
        }
        button.setTitleColor(UIColor.gray, for: .normal)
        button.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = buttonHeight * 0.5
        button.layer.borderWidth = 1.0
    }
    
    @objc func buttonTapped(sender: AnyObject) {
        print("tapped")
        if let buttonTag = actionTag(rawValue: sender.tag) {
            switch buttonTag {
            case .tapped1:
                self.delegate?.numberButtonTapped(number: "1")
            case .tapped2:
                self.delegate?.numberButtonTapped(number: "2")
            case .tapped3:
                self.delegate?.numberButtonTapped(number: "3")
            case .tapped4:
                self.delegate?.numberButtonTapped(number: "4")
            case .tapped5:
                self.delegate?.numberButtonTapped(number: "5")
            case .tapped6:
                self.delegate?.numberButtonTapped(number: "6")
            case .tapped7:
                self.delegate?.numberButtonTapped(number: "7")
            case .tapped8:
                self.delegate?.numberButtonTapped(number: "8")
            case .tapped9:
                self.delegate?.numberButtonTapped(number: "9")
            case .tapped0:
                self.delegate?.numberButtonTapped(number: "0")
            case .tappedCL:
                self.delegate?.CLButtonTapped()
            case .tappedSET:
                self.delegate?.SETButtonTapped()
            }
        }
    }
}

enum actionTag: Int {
    case tapped1 = 1
    case tapped2 = 2
    case tapped3 = 3
    case tapped4 = 4
    case tapped5 = 5
    case tapped6 = 6
    case tapped7 = 7
    case tapped8 = 8
    case tapped9 = 9
    case tapped0 = 10
    case tappedCL = 11
    case tappedSET = 12
}
