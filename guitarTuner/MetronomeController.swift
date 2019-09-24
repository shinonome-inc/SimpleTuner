//
//  MetronomeController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/24.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class MetronomeController: UIViewController, MetronomeDelegate {
    
    @IBOutlet weak var tempoView: UIView!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var metroCountView: MetroCountView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    let metronome = Metronome()
    let numberPadView = NumberPadView()
    let underLineColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.5)
    let lineWidth: CGFloat = 2
    let numberPadHeight: CGFloat = 300
    
    var beatCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metronome.delegate = self
        
        tempoLabel.isUserInteractionEnabled = true
        tempoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tappedTempoLabel)))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _ = self.initViewLayout
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
        tempoView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: underLineColor, UI: tempoView))
        startButton.layer.borderColor = UIColor.gray.cgColor
        startButton.layer.borderWidth = 1.0
        startButton.layer.cornerRadius = 25
        startButton.setTitle("START", for: .normal)
        let tempo = String(format: "%.0f", metronome.getTempo())
        tempoLabel.text = tempo
        numberPadView.frame = CGRect(x: 0, y: height, width: width, height: width * 1.2)
        numberPadView.makeView()
        self.view.addSubview(numberPadView)
        
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
        UIView.animate(withDuration: 0.2, animations: {
            self.numberPadView.frame = CGRect(x: 0, y: 0, width: width, height: width * 1.2)
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
