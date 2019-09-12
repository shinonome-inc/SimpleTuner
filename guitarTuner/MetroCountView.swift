//
//  MetroCountView.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/26.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class MetroCountView: UIView {
    
    private let circle1 = CircleLayer()
    private let circle2 = CircleLayer()
    private let circle3 = CircleLayer()
    private let circle4 = CircleLayer()
    private let circle5 = CircleLayer()
    private let circle6 = CircleLayer()
    
    var beatNumber = 4
    
    func makeView() {
        let xCenter = self.frame.width * 0.5
        let height = self.frame.height
        let materWidth = self.frame.width * 0.8
        let space = materWidth / CGFloat(beatNumber - 1)
        let diameter = xCenter * 0.1
        let radious = diameter * 0.5
        var leftSide = self.frame.width * 0.1 - radious
        let circles = [circle1, circle2, circle3, circle4, circle5, circle6]
        
        for i in 0 ..< beatNumber {
            let circle = circles[i]
            circle.path = UIBezierPath(ovalIn: CGRect.init(x: leftSide, y: height, width: diameter, height: diameter)).cgPath
            circle.drawCircle(frame: self.frame)
            self.layer.addSublayer(circle)
            leftSide = leftSide + space
           }
    }
    
    func circleLighting(beatCount: Int) {
        print("called circleLighting")
        let circles = [circle1, circle2, circle3, circle4, circle5, circle6]
        for i in 0 ..< beatCount {
            let circle = circles[i]
            lightOff(layer: circle)
        }
        let circle = circles[beatCount - 1]
        lighting(layer: circle)
    }
    
    func lighting(layer: CircleLayer) {
        print("called lighting")
        let fillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        layer.fillColor = fillColor.cgColor
    }
    
    func lightOff(layer: CircleLayer) {
        print("called lightOff")
        layer.fillColor = UIColor.clear.cgColor
    }

}
