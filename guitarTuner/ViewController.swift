//
//  ViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/05.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TunerDelegate {

    @IBOutlet weak var baseFrequencyLabel: UILabel!
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var pitchTitleLabel: UILabel!
    @IBOutlet weak var frequencyTitleLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var pitchView: UIView!
    @IBOutlet weak var frequencyView: UIView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var materView: MaterView!
    @IBOutlet weak var tunerTabBarItem: UITabBarItem!
    
    let tuner = Tuner()
    
    var scaleAffine: CGAffineTransform?
    let underLineColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.5)
    let lineWidth: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tuner.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Pitch.renewAll()
        tuner.startTuner()
        baseFrequencyLabel.text = String(format: "%.0f", Pitch.baseFrequency) + "Hz"
        print("strat tuner")
    }
    
    //こいつが呼ばれるときにはオートレイアウト後のフレームが決定している.
    //逆にviewDidLoadではまだ決定していない。なんかめちゃくちゃ呼ばれるっぽいので注意。
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //これ+下のlazyってやつで初回の一回のみsetupLayoutを呼べる。詳しくは不明。
        _ = self.initViewLayout
    }
    
    private lazy var initViewLayout : Void = {
        materView.makeMaterView()
        setupLabels()
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        tuner.stopTuner()
        print("stop tuner")
    }
   
    func setupLabels() {
        baseFrequencyLabel.text = String(format: "%.0f", Pitch.baseFrequency) + "Hz"
        noteTitleLabel.text = "Note"
        pitchTitleLabel.text = "Pitch"
        frequencyTitleLabel.text = "Frequency"
        noteView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: underLineColor, UI: noteView))
        pitchView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: underLineColor, UI: pitchView))
        frequencyView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: underLineColor, UI: frequencyView))
    }
    
   
    
    /// レイアウト系のセットアップ
    /*func setupLayout() {
        scaleAffine = CGAffineTransform(scaleX: baseView.frame.height * 0.7 / 150, y: baseView.frame.height * 0.7 / 150)
        guard let scaleAffine = scaleAffine else {
            return
        }
        materView.transform = scaleAffine
        materView.center = CGPoint(x: baseView.center.x, y: baseView.center.y + baseView.frame.height / 2 - 10)
        self.view.addSubview(materView)
        
        arrowView.transform = scaleAffine
        arrowView.center = CGPoint(x: baseView.center.x, y: baseView.center.y + baseView.frame.height / 2 - 10)
        self.view.addSubview(arrowView)
        
    }*/
    
    /// メジャーの更新
    ///
    /// - Parameters:
    ///   - pitch: Pitch
    ///   - distance: 距離
    ///   - amplitude: 振幅
    ///   - frequency: 周波数
    func tunerDidMesure(pitch: Pitch, distance: Double, amplitude: Double, frequency: Double) {
        guard amplitude > 0.2 else{
            return
        }
        guard frequency > Pitch.all[0].frequency, frequency < Pitch.all[60].frequency else {
            return
        }
        /*guard let scaleAffine = scaleAffine else {
            return
        }*/
        
        let frequencyText = String(format: "%.1f", frequency)
        let pitchFrequencyText = String(format: "%.1f", pitch.frequency)
        frequencyLabel.text = frequencyText
        pitchLabel.text = pitchFrequencyText
        noteLabel.text = "\(pitch.note)"
        //arrowView.moveArrowLayer(pitch: pitch, frequency: frequency, scaleAffine: scaleAffine)
        materView.circleLighting(pitch: pitch, frequency: frequency)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension CALayer {
    class func drawUnderLine(lineWidth: CGFloat, lineColor: UIColor, UI:AnyObject) -> CALayer{
        let line = CALayer()
        line.frame = CGRect(x: 0.0, y: (UI.frame?.size.height)! - lineWidth, width: (UI.frame?.size.width)!, height: lineWidth)
        line.backgroundColor = lineColor.cgColor
        return line
    }
 }
