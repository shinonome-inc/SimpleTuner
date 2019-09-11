//
//  Mater.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/16.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

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
            lightOff(layer: circle)
            counter += 1
        }
        for circle in circles {
            if range(standard: circle.standardFrequency, frequency: frequency) {
                lighting(layer: circle)
            }
        }
        if westCircle.standardFrequency! > frequency {
            lighting(layer: westCircle)
        }
        if eastCircle.standardFrequency! < frequency {
            lighting(layer: eastCircle)
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
    
    func lighting(layer: CircleLayer) {
        let fillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        layer.fillColor = fillColor.cgColor
    }
    
    func lightOff(layer: CircleLayer) {
        layer.fillColor = UIColor.clear.cgColor
    }
}

