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