//
//  TabBarController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2020/12/03.
//  Copyright © 2020 大谷悦志. All rights reserved.
//

import UIKit
import RxSwift
import XLPagerTabStrip

class TabBarController: ButtonBarPagerTabStripViewController {
    
    var themeColor: BaseColor = .blue
    var isInitBind: Bool = true
    let iconDisabledColor = UIColor.gray
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        if isInitBind {
            dataBind()
        }
        tabBarSetting()
        super.viewDidLoad()
    }
    
    func dataBind() {
        UserInfo.shared.colorEvent.subscribe(onNext: {
            color in
            self.themeColor = color
            if self.isInitBind {
                self.isInitBind = false
            } else {
                self.reLoadView()
            }
        }).disposed(by: disposeBag)
    }
    
    func reLoadView() {
        loadView()
        viewDidLoad()
    }
    
    func tabBarSetting() {
        settings.style.buttonBarBackgroundColor = UIColor.mainBackground
        settings.style.buttonBarItemBackgroundColor = UIColor.mainBackground
        settings.style.selectedBarBackgroundColor = UIColor.clear
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
        changeCurrentIndexProgressive = {
            oldCell, newCell, progressPercentage, changeCurrentIndex, animated in
            guard let oldCell = oldCell, let newCell = newCell else {
                return
            }
            oldCell.imageView.tintColor = self.iconDisabledColor
            newCell.imageView.tintColor = self.themeColor.sub
            self.navigationItem.title = newCell.label.text
        }
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
    
    override func configureCell(_ cell: ButtonBarViewCell, indicatorInfo: IndicatorInfo) {
        cell.imageView.tintColor = UIColor.gray
        cell.label.textColor = UIColor.clear
        if cell.isSelected {
            cell.imageView.tintColor = themeColor.sub
            self.navigationItem.title = cell.label.text
        }
    }
}
