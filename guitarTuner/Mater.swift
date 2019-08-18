//
//  Mater.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/16.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class MaterView: UIView {
    
    private let westCircle = CAShapeLayer.init()
    private let westNorthWestCircle = CAShapeLayer.init()
    private let northNorthWestCircle = CAShapeLayer.init()
    private let northCircle = CAShapeLayer.init()
    private let northNorthEastCircle = CAShapeLayer.init()
    private let eastNorthEastCircle = CAShapeLayer.init()
    private let eastCircle = CAShapeLayer.init()
    
    func makeMaterView(){
        let xCenter = self.frame.width * 0.5
        let height = self.frame.height
        let perimeter = xCenter * 0.8
        let diameter = xCenter * 0.1
        let radious = diameter * 0.5
        let viewCenter = xCenter - radious
        let harfOfRoot3: CGFloat = sqrt(3.0) * 0.5
        
        let westPath = UIBezierPath(ovalIn: CGRect.init(x: viewCenter - perimeter, y: height, width: diameter, height: diameter))
        let westNorthWestPath = UIBezierPath(ovalIn: CGRect.init(x: viewCenter - (perimeter * harfOfRoot3), y: height - (perimeter * 0.5), width: diameter, height: diameter))
        let northNorthWestPath = UIBezierPath(ovalIn: CGRect.init(x: viewCenter - (perimeter * 0.5), y: height - (perimeter * harfOfRoot3), width: diameter, height: diameter))
        let northPath = UIBezierPath(ovalIn: CGRect.init(x: viewCenter, y: height - perimeter, width: diameter, height: diameter))
        let northNorthEastPath = UIBezierPath(ovalIn: CGRect.init(x: viewCenter + (perimeter * 0.5), y: height - (perimeter * harfOfRoot3), width: diameter, height: diameter))
        let eastNorthEastPath = UIBezierPath(ovalIn: CGRect.init(x: viewCenter + (perimeter * harfOfRoot3), y: height - (perimeter * 0.5), width: diameter, height: diameter))
        let eastPath = UIBezierPath(ovalIn: CGRect.init(x: viewCenter + perimeter, y: height, width: diameter, height: diameter))
        let pathesAndLayers: [(path: UIBezierPath, layer: CAShapeLayer)] = [(westPath, westCircle),( westNorthWestPath, westNorthWestCircle), (northNorthWestPath, northNorthWestCircle), (northPath, northCircle),  (northNorthEastPath, northNorthEastCircle),  (eastNorthEastPath, eastNorthEastCircle), (eastPath, eastCircle)]
        
        for pathAndLayer in pathesAndLayers{
            makeCircle(path: pathAndLayer.path, layer: pathAndLayer.layer)
        }
        
    }
    
    func makeCircle(path: UIBezierPath, layer: CAShapeLayer) {
        let strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let fillColor = UIColor.clear
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    
        layer.path = path.cgPath
        layer.frame = frame
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        self.layer.addSublayer(layer)
    }
}

