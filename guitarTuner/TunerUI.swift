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
    private let moveLayer = CALayer.init()
    
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
    }

    /// 針のレイヤーを作成する

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

        moveLayer.addSublayer(arrowLayer)
        self.layer.addSublayer(moveLayer)
    }

    /// 針を移動させる
    ///
    /// - Parameters:
    ///   - pitch: Pitch
    ///   - frequency: 周波数

    /*func moveArrowLayer(pitch: Pitch, frequency: Double) {
        let moveArrow = CABasicAnimation(keyPath: "path")
        let arrowRate: Double
        if pitch.frequency < frequency{
            let nextPitch = pitch + 1
            arrowRate = (frequency - pitch.frequency) / ((nextPitch.frequency - pitch.frequency) / 2)
        }else {
            let beforePitch = pitch - 1
            arrowRate = (frequency - pitch.frequency) / ((pitch.frequency - beforePitch.frequency) / 2)
        }
        let movedArrowStartAngel: CGFloat = CGFloat((-1 * Double.pi) / 2 + ( Double.pi / 2 ) * arrowRate)
        let movedArrowEndAngel: CGFloat = movedArrowStartAngel + CGFloat(Double.pi / 180)
        let movedArrowPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: arrowLayer.frame.size.width / 2.0, y: arrowLayer.frame.size.height / 2.0), radius: arrowLayer.frame.size.width / 2.0, startAngle: movedArrowStartAngel, endAngle: movedArrowEndAngel, clockwise: true)

        moveArrow.isRemovedOnCompletion = false
        moveArrow.fromValue = arrowLayer.path
        moveArrow.toValue = movedArrowPath.cgPath
        moveArrow.duration = 0.2
        arrowLayer.path = movedArrowPath.cgPath
    
        arrowLayer.add(moveArrow, forKey: nil)
        self.layer.addSublayer(arrowLayer)
    }*/
    
    /*func moveArrowLayer(pitch: Pitch, frequency: Double) {
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
            moveLayer.transform = CGAffineTransform(rotationAngle: movedArrowAngel)
        }, completion: )
    }*/
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
