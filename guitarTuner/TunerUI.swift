//
//  TunerUI.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/26.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class MaterView: UIView {
    private let thinLayer = CAShapeLayer.init()
    private let thickLayer = CAShapeLayer.init()
    private let justPitchLayer = CAShapeLayer.init()
    private let propLayer = CAShapeLayer.init()
    
    func makeMaterView() {
        let strokeColor = UIColor.white.cgColor
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let startAngle: CGFloat = CGFloat(((-1 * Double.pi) / 180 ) * 180)
        let endAngle: CGFloat = CGFloat((Double.pi / 180) * 0)
        let justPitchAngle = CGFloat((-1 * Double.pi) / 2)
        
        let path: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let propPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width / 2.0) - frame.size.width / 6.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let justPitchPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width / 2.0, startAngle: justPitchAngle, endAngle: endAngle, clockwise: true)
        
        thinLayer.path = path.cgPath
        thinLayer.frame = frame
        thinLayer.strokeColor = strokeColor
        thinLayer.lineWidth = 16.0
        thinLayer.fillColor = UIColor.clear.cgColor
        thinLayer.lineDashPattern = [ 0.5, 5.55 ]
        thinLayer.lineDashPhase = 0.25
        self.layer.addSublayer(thinLayer)
        
        thickLayer.path = path.cgPath
        thickLayer.frame = frame
        thickLayer.strokeColor = strokeColor
        thickLayer.lineWidth = 20.0
        thickLayer.fillColor = UIColor.clear.cgColor
        thickLayer.lineDashPattern = [ 2.0, 469 ]
        thickLayer.lineDashPhase = 1.0
        self.layer.addSublayer(thickLayer)
        
        propLayer.path = propPath.cgPath
        propLayer.frame = frame
        propLayer.strokeColor = strokeColor
        propLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(propLayer)
        
        justPitchLayer.path = justPitchPath.cgPath
        justPitchLayer.frame = frame
        justPitchLayer.strokeColor = strokeColor
        justPitchLayer.lineWidth = 30.0
        justPitchLayer.fillColor = UIColor.clear.cgColor
        justPitchLayer.lineDashPattern = [ 3.0, 300]
        justPitchLayer.lineDashPhase = 1.5
        self.layer.addSublayer(justPitchLayer)
        
    }

}
