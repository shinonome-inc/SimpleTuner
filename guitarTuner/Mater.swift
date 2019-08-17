//
//  Mater.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/16.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class MaterView: UIView {
    
    private let materCircle = CAShapeLayer.init()
    
    func makeMaterView(){
        let xCenter = self.frame.width * 0.5
        let height = self.frame.height
        let perimeter = xCenter * 0.8
        let radious = xCenter * 0.1
        let path1 = UIBezierPath(ovalIn: CGRect.init(x: xCenter - perimeter, y: height, width: radious, height: radious))
        let path2 = UIBezierPath(ovalIn: CGRect.init(x: xCenter - (perimeter * 1.57), y: height, width: radious, height: radious))
        let path3 = UIBezierPath(ovalIn: CGRect.init(x: xCenter - (perimeter * 0.5), y: height, width: radious, height: radious))
        let path4 = UIBezierPath(ovalIn: CGRect.init(x: xCenter, y: , width: <#T##CGFloat#>, height: <#T##CGFloat#>))
        
        
    }
    
    func makeCircle() {
        let strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let fillColor = UIColor.clear
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let path: UIBezierPath = UIBezierPath(ovalIn: CGRect.init(x: frame.width / 2, y: frame.height / 2, width: frame.width / 10, height: frame.width / 10))
        materCircle.path = path.cgPath
        materCircle.frame = frame
        materCircle.strokeColor = strokeColor.cgColor
        materCircle.fillColor = fillColor.cgColor
        self.layer.addSublayer(materCircle)
    }
}
