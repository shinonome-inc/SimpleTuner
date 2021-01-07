//
//  Color.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2021/01/06.
//  Copyright © 2021 大谷悦志. All rights reserved.
//

import UIKit

enum BaseColor {
    case blue
    case pink
    case yellow
    case green
    case beige
    
    func main() -> UIColor{
        let color: UIColor?
        switch self {
        case .blue:
            color = UIColor(named: "mainBlue")
        case .pink:
            color = UIColor(named: "mainRed")
        case .yellow:
            color = UIColor(named: "mainYellow")
        case .green:
            color = UIColor(named: "mainGreen")
        case .beige:
            color = UIColor(named: "mainBeige")
        }
        guard let mainColor = color else {
            fatalError()
        }
        return mainColor
    }
    
    func sub() -> UIColor{
        let color: UIColor?
        switch self {
        case .blue:
            color = UIColor(named: "subBlue")
        case .pink:
            color = UIColor(named: "subRed")
        case .yellow:
            color = UIColor(named: "subYellow")
        case .green:
            color = UIColor(named: "subGreen")
        case .beige:
            color = UIColor(named: "subBeige")
        }
        guard let subColor = color else {
            fatalError()
        }
        return subColor
    }
}
