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
    
    let metronome = Metronome()
    let underLineColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.5)
    let lineWidth: CGFloat = 2
    
    var beatCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metronome.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _ = self.initViewLayout
    }
    
    private lazy var initViewLayout : Void = {
        metroCountView.makeView()
        setupLabels()
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        print("start metro")
        metronome.startMetro()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("stop metro")
        metronome.stopMetro()
    }
    
    func setupLabels() {
        tempoView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: underLineColor, UI: tempoView))
    }
    
    @IBAction func tappedMinus(_ sender: Any) {
        metronome.tempoMinus1()
    }
    
    @IBAction func tappedPlus(_ sender: Any) {
        metronome.tempoPlus1()
    }
    
    @IBAction func tappedStart(_ sender: Any) {
    }
    
    func metronomeDidBeat() {
        print("DID Beat")
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
