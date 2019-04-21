//
//  ViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/05.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
   
    let materView = MaterView(frame: CGRect(x: 0, y: 0, width: 245, height: 245))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tuner = Tuner()
        tuner.startTuner()
        
        MaterView.frame = CGRect(
            origin: CGPoint(x: round(self.view.bounds.width -141) / 2, y: round(self.view.bounds.height - 141) / 2)
            size: CGSize(width: 141, height: 141)
        )
    

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

