//
//  ViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/05.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit
import SVGKit

class ViewController: UIViewController,TunerDelegate {

    @IBOutlet weak var baseFrequencyLabel: UILabel!
   
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var pitchTitleLabel: UILabel!
    @IBOutlet weak var frequencyTitleLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    
    let tuner = Tuner()
    
    var scaleAffine: CGAffineTransform?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tuner.delegate = self
        self.view.backgroundColor = UIColor.white
        setupLabels()
        //こっちだといけた。
        /*let buttonImage = SVGKImage(named: "cog")
        buttonImage?.size = CGSize(width: 25, height: 25)
        editButton.image = buttonImage?.uiImage
        
        materView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        materView.makeMaterView()
        
        arrowView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        arrowView.makeArrowLayer()*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Pitch.renewAll()
        tuner.startTuner()
        print("strat")
    }
    
    //こいつが呼ばれるときにはオートレイアウト後のフレームが決定している.
    //逆にviewDidLoadではまだ決定していない。なんかめちゃくちゃ呼ばれるっぽいので注意。
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //これ+下のlazyってやつで初回の一回のみsetupLayoutを呼べる。詳しくは不明。
        _ = self.initViewLayout
    }
    
    private lazy var initViewLayout : Void = {
        //setupLayout()
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        tuner.stopTuner()
        print("stop")
    }
   
    func setupLabels() {
        baseFrequencyLabel.text = String(Pitch.baseFrequency) + "Hz"
        noteTitleLabel.text = "Note"
        pitchTitleLabel.text = "Pitch"
        frequencyTitleLabel.text = "Frequency"
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
        print(Pitch.baseFrequency)
        print(Pitch.all[45].frequency)
        guard amplitude > 0.01 else{
            return
        }
        guard frequency > Pitch.all[0].frequency, frequency < Pitch.all[60].frequency else {
            return
        }
        guard let scaleAffine = scaleAffine else {
            return
        }
        
        let frequencyText = String(format: "%.1f", frequency)
        let pitchFrequencyText = String(format: "%.1f", pitch.frequency)
        frequencyLabel.text = frequencyText
        pitchLabel.text = pitchFrequencyText
        noteLabel.text = "\(pitch.note)"
        //arrowView.moveArrowLayer(pitch: pitch, frequency: frequency, scaleAffine: scaleAffine)
        
        if fabs(distance) < 0.1 {
            noteLabel.textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }else{
            noteLabel.textColor = UIColor.white
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

/*extension CALayer {
    class func drawUnderLine(lineWidth: CGFloat, lineColor: UIColor, UI:AnyObject) -> CALayer{
        let line = CALayer()
        line.frame = CGRect(x: 0.0, y: (UI.frame?.size.height)! - lineWidth, width: (UI.frame?.size.width)!, height: lineWidth)
        line.backgroundColor = lineColor.cgColor
        return line
    }
 }*/
