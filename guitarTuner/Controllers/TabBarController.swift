//
//  TabBarController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2020/12/03.
//  Copyright © 2020 大谷悦志. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TabBarController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        tabBarSetting()
        super.viewDidLoad()
    }
    
    func tabBarSetting() {
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.5)
        settings.style.buttonBarMinimumLineSpacing = 20
        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyboard.instantiateViewController(identifier: "TunerViewController") as! TunerViewController
        let VC2 = storyboard.instantiateViewController(identifier: "MetronomeController") as! MetronomeController
        let VC3 = storyboard.instantiateViewController(identifier: "SoundMaterViewController") as! SoundMaterViewController
        let VC4 = storyboard.instantiateViewController(identifier: "SettingViewController") as! SettingViewController
        let childViewControllers: [UIViewController] = [VC1, VC2, VC3, VC4]
        
        return childViewControllers
    }
}
