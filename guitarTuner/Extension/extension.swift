//
//  extension.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2021/01/04.
//  Copyright © 2021 大谷悦志. All rights reserved.
//

import UIKit

extension UIColor {
    class var mainBackground: UIColor {
        guard let color = UIColor(named: "mainBackground") else {
            return UIColor.white
        }
        return color
    }
    
    class var mainTextColor: UIColor {
        guard let color = UIColor(named: "mainTextColor") else {
            return UIColor.white
        }
        return color
    }
}

extension CALayer {
    class func drawUnderLine(lineWidth: CGFloat = 2, lineColor: UIColor, UI: AnyObject) -> CALayer{
        let line = CALayer()
        line.frame = CGRect(x: 0.0, y: (UI.frame?.size.height)! - lineWidth, width: (UI.frame?.size.width)!, height: lineWidth)
        line.backgroundColor = lineColor.cgColor
        return line
    }
 }

extension UIView {
    func cardView() {
        self.layer.cornerRadius = 8
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}

extension Notification.Name {
    static let tappedSET = Notification.Name(rawValue: "tappedSET")
}
