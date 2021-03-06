//
//  MetronomeController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/24.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit
import RxSwift
import XLPagerTabStrip

class MetronomeController: UIViewController, MetronomeDelegate {
    
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var tempoView: UnderLineView!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var metroCountView: MetroCountView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    let metroTabBarController = UITabBarController()
    let metronome = Metronome()
    let numberPadView = NumberPadView()
    let disposeBag = DisposeBag()
    let lineWidth: CGFloat = 2
    var tempoLabelFrame: CGRect?
    var beatCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metronome.delegate = self
        numberPadView.delegate = self
        
        tempoLabel.isUserInteractionEnabled = true
        tempoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tappedTempoLabel)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dataBind()
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
            metroCountView.refresh()
            beatCounter = 0
        }
    }
    
    func setupUIs() {
        let height = self.view.frame.height
        let width = self.view.frame.width
        let numberPadHeight = width * 1.2
        
        //labels
        let tempo = String(format: "%.0f", metronome.getTempo())
        tempoLabel.text = tempo
        tempoLabelFrame = tempoLabel.frame
        
        //buttons
        startButton.layer.borderColor = UIColor.gray.cgColor
        startButton.layer.borderWidth = 1.0
        startButton.layer.cornerRadius = 25
        startButton.setTitle("START", for: .normal)
        
        //views
        numberPadView.frame = CGRect(x: 0, y: height, width: width, height: numberPadHeight)
        numberPadView.makeView()
        self.view.addSubview(numberPadView)
        tempoView.drawUnderLine()
    }
    
    func dataBind() {
        UserInfo.shared.colorEvent.subscribe(onNext: {
            color in
            self.tempoView.line.backgroundColor = color.main.cgColor
        }).disposed(by: disposeBag)
    }
    
    func drawLabelUnderLine(color: UIColor) {
        //tempoView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: color, UI: tempoView))
    }
    
    @IBAction func tappedMinus(_ sender: Any) {
        guard metronome.getTempo() > 1 else {
            return
        }
        metronome.tempoMinus1()
        let tempo = String(format: "%.0f", metronome.getTempo())
        tempoLabel.text = tempo
    }
    
    @IBAction func tappedPlus(_ sender: Any) {
        guard metronome.getTempo() < 300 else {
            return
        }
        metronome.tempoPlus1()
        let tempo = String(format: "%.0f", metronome.getTempo())
        tempoLabel.text = tempo
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
        let numberPadHeight = width * 1.2
        let tabBarHeight = metroTabBarController.tabBar.frame.height
        self.tempoLabel.translatesAutoresizingMaskIntoConstraints = true
        guard let tempoLabelFrame = tempoLabelFrame else {
            return
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.numberPadView.frame = CGRect(x: 0, y: height - numberPadHeight - tabBarHeight, width: width, height: numberPadHeight)
            self.tempoLabel.frame = CGRect(x: tempoLabelFrame.origin.x, y: height - numberPadHeight - tabBarHeight - tempoLabelFrame.height, width: tempoLabelFrame.width, height: tempoLabelFrame.height)
            self.hideView.backgroundColor = UIColor.white
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

extension MetronomeController: NumberPadViewDelegate {
    
    func numberButtonTapped(number: String) {
        
        if numberPadView.firstTouch {
            tempoLabel.text = number
            numberPadView.firstTouch = false
            return
        }
        
        if tempoLabel.text == "0" {
            tempoLabel.text = number
            return
        }
        
        if var tempoLabelText = tempoLabel.text{
            tempoLabelText = tempoLabelText + number
            if Int(tempoLabelText)! > 300 {
                tempoLabel.text = "300"
                return
            }else{
                tempoLabel.text = tempoLabelText
            }
        }else{
            tempoLabel.text = number
        }
    }
    
    func CLButtonTapped() {
        tempoLabel.text = "0"
        numberPadView.firstTouch = true
    }
    
    func SETButtonTapped() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let numberPadHeight = width * 1.2
        
        guard let tempoLabelText = tempoLabel.text else{
            return
        }
        guard let settedTempoInt = Int(tempoLabelText) else {
            return
        }
        guard settedTempoInt > 0 else{
            return
        }
        let settedTempo = Double(tempoLabelText)
        metronome.setTenpo(settedTenpo: settedTempo!)
        numberPadView.firstTouch = true
        guard let tempoLabelFrame = tempoLabelFrame else {
            return
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.numberPadView.frame = CGRect(x: 0, y: height, width: width, height: numberPadHeight)
            self.tempoLabel.frame = CGRect(x: tempoLabelFrame.origin.x, y: tempoLabelFrame.origin.y, width: tempoLabelFrame.width, height: tempoLabelFrame.height)
            self.hideView.backgroundColor = UIColor.clear
        })
    }
}

extension MetronomeController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let info = IndicatorInfo(image: UIImage(named: "metronome"))
        return info
    }
}

