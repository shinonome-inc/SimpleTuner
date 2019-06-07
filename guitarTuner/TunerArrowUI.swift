//
//  TunerArrowUI.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/05/31.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class ArrowView: UIView {
    private let arrowLayer = CAShapeLayer.init()
    
    func makeArrowLayer() {
        let arrowStartAngel: CGFloat = CGFloat((-1 * Double.pi) / 2)
        let arrowEndAngel: CGFloat = arrowStartAngel + CGFloat(Double.pi / 180)
        let arrowPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width / 2.0, startAngle: arrowStartAngel, endAngle: arrowEndAngel, clockwise: true)
        
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.frame = frame
        arrowLayer.strokeColor = UIColor.red.cgColor
        arrowLayer.lineWidth = 100
        arrowLayer.fillColor = UIColor.clear.cgColor
        arrowLayer.lineDashPattern = [ 1.5, 718.5 ]
        arrowLayer.lineDashPhase = 0.75
        
        self.layer.addSublayer(arrowLayer)
    }
    
    func moveArrowLayer(pitch: Pitch, frequency: Double) {
        let arrowRate: Double
        
        if pitch.frequency < frequency{
            let nextPitch = pitch + 1
            arrowRate = (frequency - pitch.frequency) / ((nextPitch.frequency - pitch.frequency) / 2)
        }else {
            let beforePitch = pitch - 1
            arrowRate = (frequency - pitch.frequency) / ((pitch.frequency - beforePitch.frequency) / 2)
        }
        let movedArrowAngel: CGFloat = CGFloat((-1 * Double.pi) / 2 + ( Double.pi / 2 ) * arrowRate)
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(rotationAngle: movedArrowAngel)
        })
    }
}
