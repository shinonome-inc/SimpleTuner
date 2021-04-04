//
//  MetronomeController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/24.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import XLPagerTabStrip

class MetronomeController: UIViewController, MetronomeDelegate {
    
    @IBOutlet weak var tempoView: UnderLineView!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var metroCountView: MetroCountView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var tempoSettingView: UIView!
    
    let metronome = Metronome()
    let disposeBag = DisposeBag()
    let lineWidth: CGFloat = 2
    var tempoLabelFrame: CGRect?
    var beatCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metronome.delegate = self
        
        tempoLabel.isUserInteractionEnabled = true
        tempoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tappedTempoLabel)))
        NotificationCenter.default.addObserver(self, selector: #selector(finishTempoSetting(notification:)), name: .tappedSET, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dataBind()
        tempoSettingView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        _ = self.initViewLayout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //backgroundImageView.setImage()
    }
    
    private lazy var initViewLayout : Void = {
        metroCountView.makeView()
        setupUIs()
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        if metronome.isActivated == true {
            metronome.stopMetro()
            startButton.setTitle("START", for: .normal)
            metroCountView.refresh()
            beatCounter = 0
        }
    }
    
    func setupUIs() {
        //labels
        let tempo = String(format: "%.0f", metronome.getTempo())
        tempoLabel.text = tempo
        tempoLabelFrame = tempoLabel.frame
        
        //buttons
        startButton.layer.borderColor = UIColor.gray.cgColor
        startButton.layer.borderWidth = 1.0
        startButton.layer.cornerRadius = startButton.frame.height / 4
        startButton.setTitle("START", for: .normal)
        
        //views
        tempoView.drawUnderLine()
    }
    
    func dataBind() {
        UserInfo.shared.colorEvent.subscribe(onNext: {
            color in
            self.tempoView.line.backgroundColor = color.main.cgColor
            self.metroCountView.color = color
        }).disposed(by: disposeBag)
        UserInfo.shared.tempoEvent.subscribe(onNext: {
            tempo in
            self.tempoLabel.text = String(format: "%.0f", tempo)
        }).disposed(by: disposeBag)
    }
    
    @objc func finishTempoSetting(notification: NSNotification) {
        let width = self.view.frame.width
        let height = self.view.frame.height
        UIView.animate(withDuration: 0.2, animations: {
            self.tempoSettingView.frame = CGRect(x: 0, y: height, width: width, height: height)
        })
        metronome.setTenpo(settedTenpo: notification.object as! Double)
    }
    
    @IBAction func tappedMinus(_ sender: Any) {
        guard metronome.getTempo() > 1 else {
            return
        }
        metronome.tempoMinus1()
    }
    
    @IBAction func tappedPlus(_ sender: Any) {
        guard metronome.getTempo() < 300 else {
            return
        }
        metronome.tempoPlus1()
    }
    
    @IBAction func tappedStart(_ sender: Any) {
        if metronome.isActivated == false {
            startButton.setTitle("STOP", for: .normal)
            metronome.startMetro()
        } else {
            startButton.setTitle("START", for: .normal)
            metronome.stopMetro()
            metroCountView.refresh()
            beatCounter = 0
        }
    }
    
    @objc func tappedTempoLabel(sender: UITapGestureRecognizer) {
        let width = self.view.frame.width
        let height = self.view.frame.height
        UIView.animate(withDuration: 0.2, animations: {
            self.tempoSettingView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        })
    }
    
    func metronomeDidBeat() {
        beatCounter += 1
        metroCountView.circleLighting(beatCount: beatCounter)
        if beatCounter >= metronome.getBeatNumber() {
            beatCounter = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MetronomeController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let info = IndicatorInfo(title: "Metro", image: UIImage(named: "metronome")?.withRenderingMode(.alwaysTemplate))
        return info
    }
}

