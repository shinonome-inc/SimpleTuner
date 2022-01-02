//
//  extension.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2021/01/04.
//  Copyright © 2021 大谷悦志. All rights reserved.
//

import UIKit

extension CALayer {
    class func drawUnderLine(lineWidth: CGFloat = 2, lineColor: UIColor, UI: AnyObject) -> CALayer{
        let line = CALayer()
        line.frame = CGRect(x: 0.0, y: (UI.frame?.size.height)! - lineWidth, width: (UI.frame?.size.width)!, height: lineWidth)
        line.backgroundColor = lineColor.cgColor
        return line
    }
 }
