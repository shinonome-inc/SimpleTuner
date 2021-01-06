//
//  SoundMaterViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2020/11/28.
//  Copyright © 2020 大谷悦志. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SoundMaterViewController: UIViewController {
    
    @IBOutlet weak var soundBar1: UIView!
    @IBOutlet weak var soundBar2: UIView!
    @IBOutlet weak var soundBar3: UIView!
    @IBOutlet weak var soundBar4: UIView!
    @IBOutlet weak var soundBar5: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amplitudeLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    let underLineColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.5)
    let lineWidth: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundAnalizer.shared.soundMaterDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _ = self.initViewLayout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SoundAnalizer.shared.startSoundMater()
        print("sound mater start")
    }
    
    private lazy var initViewLayout : Void = {
        setupLayout()
    }()
    
    func setupLayout() {
        titleLabel.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: underLineColor, UI: titleLabel))
        unitLabel.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: underLineColor, UI: unitLabel))
    }
}

extension SoundMaterViewController: SoundMaterDelegate {
    func soundMaterDidMesure(dB: Double) {
        print(dB)
        amplitudeLabel.text = String(format: "%.0f", dB)
        let index = Int(dB / 20)
        let soundBars = [soundBar1, soundBar2, soundBar3, soundBar4, soundBar5]
        soundBars.forEach({ soundBar in
            soundBar?.backgroundColor = UIColor.lightGray
        })
        for count in 0 ... index {
            soundBars[count]?.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.5)
        }
    }
}

extension SoundMaterViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let info = IndicatorInfo(image: UIImage(named: "sound"))
        return info
    }
}
