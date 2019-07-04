//
//  MaterView.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/21.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class MaterView: UIView {
    private let thinLayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let strockColor = UIColor.black.cgColor
        
        
        let path = UIBezierPath(arcCenter: CGPoint(x: 200, y: 200), radius: 100, startAngle: 0, endAngle: CGFloat(Double.pi)*1/2, clockwise: true).cgPath
        thinLayer.path = path
        thinLayer.strokeColor = strockColor
        thinLayer.lineWidth = 16.0
        thinLayer.fillColor = UIColor.clear.cgColor
        thinLayer.lineDashPattern = [ 0.5, 5.5 ]
        thinLayer.lineDashPhase = 0.25
        thinLayer.addSublayer(thinLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
