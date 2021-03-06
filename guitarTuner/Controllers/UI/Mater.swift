//
//  Mater.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/16.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit
import RxSwift

class MaterView: UIView {
    
    private let westCircle = CircleLayer()
    private let westNorthWestCircle = CircleLayer()
    private let northNorthWestCircle = CircleLayer()
    private let northCircle = CircleLayer()
    private let northNorthEastCircle = CircleLayer()
    private let eastNorthEastCircle = CircleLayer()
    private let eastCircle = CircleLayer()
    
    func makeMaterView() {
        let xCenter = self.frame.width * 0.5
        let height = self.frame.height
        let perimeter = xCenter * 0.8
        let diameter = xCenter * 0.1
        let radious = diameter * 0.5
        let viewCenter = xCenter - radious
        let harfOfRoot3: CGFloat = sqrt(3.0) * 0.5
        
        westCircle.path = UIBezierPath(ovalIn: CGRect.init(x: viewCenter - perimeter, y: height, width: diameter, height: diameter)).cgPath
        westNorthWestCircle.path = UIBezierPath(ovalIn: CGRect.init(x: viewCenter - (perimeter * harfOfRoot3), y: height - (perimeter * 0.5), width: diameter, height: diameter)).cgPath
        northNorthWestCircle.path = UIBezierPath(ovalIn: CGRect.init(x: viewCenter - (perimeter * 0.5), y: height - (perimeter * harfOfRoot3), width: diameter, height: diameter)).cgPath
        northCircle.path = UIBezierPath(ovalIn: CGRect.init(x: viewCenter, y: height - perimeter, width: diameter, height: diameter)).cgPath
        northNorthEastCircle.path = UIBezierPath(ovalIn: CGRect.init(x: viewCenter + (perimeter * 0.5), y: height - (perimeter * harfOfRoot3), width: diameter, height: diameter)).cgPath
        eastNorthEastCircle.path = UIBezierPath(ovalIn: CGRect.init(x: viewCenter + (perimeter * harfOfRoot3), y: height - (perimeter * 0.5), width: diameter, height: diameter)).cgPath
        eastCircle.path = UIBezierPath(ovalIn: CGRect.init(x: viewCenter + perimeter, y: height, width: diameter, height: diameter)).cgPath
        let circles = [westCircle, westNorthWestCircle, northNorthWestCircle, northCircle, northNorthEastCircle, eastNorthEastCircle, eastCircle]
        
        for circle in circles{
            circle.drawCircle(frame: self.frame)
            self.layer.addSublayer(circle)
        }
    }
    
    func circleLighting(pitch: Pitch, frequency: Double) {
        let width = 0.30
        var counter = 0.0
        let circles = [westCircle, westNorthWestCircle, northNorthWestCircle, northCircle, northNorthEastCircle, eastNorthEastCircle, eastCircle]
        westCircle.standardFrequency = pitch.frequency - (width * 3)
        for circle in circles {
            circle.standardFrequency = westCircle.standardFrequency! + (width * counter)
            circle.lightOff()
            counter += 1
        }
        for circle in circles {
            if range(standard: circle.standardFrequency, frequency: frequency) {
                circle.lighting()
            }
        }
        if westCircle.standardFrequency! > frequency {
            westCircle.lighting()
        }
        if eastCircle.standardFrequency! < frequency {
            eastCircle.lighting()
        }
    }
    
    func range(standard: Double?, frequency: Double) -> Bool{
        
        guard let standard = standard else {
            return false
        }
        let absoulute = fabs(standard - frequency)
        if absoulute <= 0.15 {
            return true
        }
        return false
    }
}

class MaterView2: UIView {
    private let thinLayer = CAShapeLayer.init()
    private let thickLayer = CAShapeLayer.init()
    private let justPitchLayer = CAShapeLayer.init()
    private let propLayer = CAShapeLayer.init()
    
    func makeMaterView() {
        let color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let strokeColor = color.cgColor
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let startAngle: CGFloat = CGFloat(((-1 * Double.pi) / 180 ) * 150)
        let endAngle: CGFloat = CGFloat((-1 * Double.pi / 180) * 30)
        let justPitchAngle = CGFloat((-1 * Double.pi) / 2)
        let propPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let justPitchPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width / 2.0 - 15, startAngle: justPitchAngle, endAngle: endAngle, clockwise: true)
        
        propLayer.path = propPath.cgPath
        propLayer.frame = frame
        propLayer.strokeColor = strokeColor
        propLayer.lineWidth = 3
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

class ArrowView: UIView {
    private let arrowLayer = CAShapeLayer.init()
    var color: UIColor?
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dataBind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.arrowLayer.fillColor = color?.cgColor
        self.arrowLayer.strokeColor = color?.cgColor
    }
    
    private func dataBind() {
        UserInfo.shared.colorEvent.subscribe(onNext: {
            color in
            self.color = color.sub
        }).disposed(by: disposeBag)
    }
    
    func makeArrowLayer() {
        guard let color = color else {
            return
        }
        let width = self.frame.width
        let height = self.frame.height
        let frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: width / 2, y: height / 12))
        arrowPath.addLine(to: CGPoint(x: width / 2 + 1, y: height / 2))
        arrowPath.addLine(to: CGPoint(x: width / 2 - 1, y: height / 2))
        arrowPath.close()
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.frame = frame
        arrowLayer.strokeColor = color.cgColor
        arrowLayer.fillColor = color.cgColor
        arrowLayer.lineWidth = 2
        self.layer.addSublayer(arrowLayer)
    }
    
    func moveArrowLayer(pitch: Pitch, frequency: Double, scaleAffine: CGAffineTransform) {
        var arrowRate: Double
        
        if pitch.frequency < frequency{
            let nextPitch = pitch + 1
            arrowRate = (frequency - pitch.frequency) / ((nextPitch.frequency - pitch.frequency) / 2)
        }else {
            let beforePitch = pitch - 1
            arrowRate = (frequency - pitch.frequency) / ((pitch.frequency - beforePitch.frequency) / 2)
        }
        
        if arrowRate > 1 {
            arrowRate = 1
        }
        if arrowRate < -1 {
            arrowRate = -1
        }
        let movedArrowAngel: CGFloat = CGFloat(( Double.pi / 2 ) * arrowRate)
        
        UIView.animate(withDuration: 0.2, animations: {
            //.concatenating()で行列同士の掛け算をしている。かける順番が変わると結果も変わるので要検索。
            let rotateAffine = CGAffineTransform(rotationAngle: movedArrowAngel)
            let affine = scaleAffine.concatenating(rotateAffine)
            self.transform = affine
        })
    }
}
