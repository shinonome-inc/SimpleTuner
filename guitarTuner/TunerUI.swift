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
    private let arrowLayer = CAShapeLayer.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let strokeColor = UIColor.black.cgColor
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let startAngle: CGFloat = CGFloat(-1 * Double.pi)
        let endAngle: CGFloat = CGFloat(0.0)
        
        let path: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        thinLayer.path = path.cgPath
        thinLayer.frame = frame
        thinLayer.strokeColor = strokeColor
        thinLayer.lineWidth = 16.0
        thinLayer.fillColor = UIColor.clear.cgColor
        thinLayer.lineDashPattern = [ 0.5, 5.5 ]
        thinLayer.lineDashPhase = 0.25
        self.layer.addSublayer(thinLayer)
        
        thickLayer.path = path.cgPath
        thickLayer.frame = frame
        thickLayer.strokeColor = strokeColor
        thickLayer.lineWidth = 16.0
        thickLayer.fillColor = UIColor.clear.cgColor
        thickLayer.lineDashPattern = [ 1.5, 58.5 ]
        thickLayer.lineDashPhase = 0.75
        self.layer.addSublayer(thickLayer)
        
        let arrowStartAngel: CGFloat = CGFloat((-1 * Double.pi) / 2)
        let arrowPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width / 2.0, startAngle: arrowStartAngel, endAngle: endAngle, clockwise: true)
        
        
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.frame = frame
        arrowLayer.strokeColor = UIColor.red.cgColor
        arrowLayer.lineWidth = 32.0
        arrowLayer.fillColor = UIColor.clear.cgColor
        arrowLayer.lineDashPattern = [ 1.5, 718.5 ]
        arrowLayer.lineDashPhase = 0.75
        self.layer.addSublayer(arrowLayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
