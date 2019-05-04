//
//  ViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/05.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    let materView = MaterView(frame: CGRect.init(x: 0, y: 0, width: 245, height: 245))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tuner = Tuner()
        tuner.startTuner()
        
        materView.frame = CGRect(x: (self.view.bounds.width - 245) / 2, y: (self.view.bounds.height - 245) / 2, width: 245, height: 245)
        self.view.addSubview(materView)
    

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

