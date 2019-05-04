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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let strokeColor = UIColor.black.cgColor
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let startAngle: CGFloat = CGFloat(0.0)
        let endAngle: CGFloat = CGFloat(Double.pi * 2.0)
        
        let path: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        thinLayer.path = path.cgPath
        thinLayer.frame = frame
        thinLayer.strokeColor = strokeColor
        thinLayer.lineWidth = 16.0
        thinLayer.fillColor = UIColor.clear.cgColor
        thinLayer.lineDashPattern = [ 0.5, 5.5 ]
        thinLayer.lineDashPhase = 0.25
        self.layer.addSublayer(thinLayer)
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
