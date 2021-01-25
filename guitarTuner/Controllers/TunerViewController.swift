//
//  ViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/05.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift

class TunerViewController: UIViewController, TunerDelegate {

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
    
    var scaleAffine: CGAffineTransform?
    let lineWidth: CGFloat = 2
    let disposeBag = DisposeBag()
    let materView2 = MaterView2()
    let arrowView = ArrowView()

    override func viewDidLoad() {
        super.viewDidLoad()
        SoundAnalizer.shared.tunerDelegate = self
        materView2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        materView2.makeMaterView()
        arrowView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        arrowView.makeArrowLayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Pitch.renewAll()
        SoundAnalizer.shared.startTuner()
        dataBind()
        baseFrequencyLabel.text = String(format: "%.0f", Pitch.baseFrequency) + "Hz"
        //backgroundImageView.setImage()
        print("strat tuner")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = self.initViewLayout
    }
    
    private lazy var initViewLayout : Void = {
        //materView.makeMaterView()
        setupLabels()
        setupLayout()
    }()
    
    func dataBind() {
        UserInfo.shared.colorEvent.subscribe(onNext: {
            color in
            self.drawLabelUnderLine(color: color.main)
        }).disposed(by: disposeBag)
    }
   
    func setupLabels() {
        baseFrequencyLabel.text = String(format: "%.0f", Pitch.baseFrequency) + "Hz"
        noteTitleLabel.text = "Note"
        pitchTitleLabel.text = "Pitch"
        frequencyTitleLabel.text = "Frequency"
    }
    
    func drawLabelUnderLine(color: UIColor) {
        noteView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: color, UI: noteView))
        pitchView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: color, UI: pitchView))
        frequencyView.layer.addSublayer(CALayer.drawUnderLine(lineWidth: lineWidth, lineColor: color, UI: frequencyView))
    }
    
    func setupLayout() {
        scaleAffine = CGAffineTransform(scaleX: 1.1, y: 1)
        guard let scaleAffine = scaleAffine else {
            return
        }
        materView2.transform = scaleAffine
        materView2.center = CGPoint(x: materView.center.x, y: materView.frame.height)
        self.view.addSubview(materView2)
        
        arrowView.transform = scaleAffine
        arrowView.center = CGPoint(x: materView.center.x, y: materView.frame.height)
        self.view.addSubview(arrowView)
    }
    
    func tunerDidMesure(pitch: Pitch, distance: Double, amplitude: Double, frequency: Double) {
        guard amplitude > 0.2 else{
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
        arrowView.moveArrowLayer(pitch: pitch, frequency: frequency, scaleAffine: scaleAffine)
        //materView.circleLighting(pitch: pitch, frequency: frequency)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TunerViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let info = IndicatorInfo(image: UIImage(named: "tuningFork"))
        return info
    }
}
