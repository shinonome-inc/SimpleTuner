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
    @IBOutlet weak var pitchView: UnderLineView!
    @IBOutlet weak var frequencyView: UnderLineView!
    @IBOutlet weak var noteView: UnderLineView!
    @IBOutlet weak var materBaseView: UIView!
    
    var scaleAffine: CGAffineTransform?
    let lineWidth: CGFloat = 2
    let disposeBag = DisposeBag()
    let materView = MaterView()
    let arrowView = ArrowView()

    override func viewDidLoad() {
        super.viewDidLoad()
        SoundAnalizer.shared.tunerDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dataBind()
        _ = self.initViewLayout
    }
    
    private lazy var initViewLayout : Void = {
        setupUIs()
    }()
    
    func dataBind() {
        UserInfo.shared.colorEvent.subscribe(onNext: {
            color in
            self.noteView.line.backgroundColor = color.main.cgColor
            self.pitchView.line.backgroundColor = color.main.cgColor
            self.frequencyView.line.backgroundColor = color.main.cgColor
        }).disposed(by: disposeBag)
        
        UserInfo.shared.baseFrequencyEvent.subscribe(onNext: {
            baseFrequency in
            self.baseFrequencyLabel.text = String(format: "%.0f", baseFrequency) + "Hz"
        }).disposed(by: disposeBag)
    }
   
    func setupUIs() {
        //labels
        noteTitleLabel.text = "Note"
        pitchTitleLabel.text = "Pitch"
        frequencyTitleLabel.text = "Frequency"
        
        //views
        scaleAffine = CGAffineTransform(scaleX: 1.1, y: 1)
        materView.frame.size = CGSize(width: materBaseView.frame.width, height: materBaseView.frame.width)
        materView.center = CGPoint(x: materBaseView.center.x, y: materBaseView.frame.height)
        materView.makeMaterView()
        self.view.addSubview(materView)
        self.view.sendSubviewToBack(materView)
        arrowView.frame.size = CGSize(width: materBaseView.frame.width, height: materBaseView.frame.width)
        arrowView.center = CGPoint(x: materBaseView.center.x, y: materBaseView.frame.height)
        arrowView.makeArrowLayer()
        self.view.addSubview(arrowView)
        self.view.sendSubviewToBack(arrowView)
        noteView.drawUnderLine()
        pitchView.drawUnderLine()
        frequencyView.drawUnderLine()
    }
    
    func tunerDidMesure(pitch: Pitch, distance: Double, amplitude: Double, frequency: Double) {
        guard amplitude > 0.1,
              frequency > Pitch.all[0].frequency,
              frequency < Pitch.all[60].frequency,
              let scaleAffine = scaleAffine else {
            return
        }
        
        let frequencyText = String(format: "%.1f", frequency)
        let pitchFrequencyText = String(format: "%.1f", pitch.frequency)
        frequencyLabel.text = frequencyText
        pitchLabel.text = pitchFrequencyText
        noteLabel.text = "\(pitch.note)"
        arrowView.moveArrowLayer(pitch: pitch, frequency: frequency, scaleAffine: scaleAffine)
    }
    
    @IBAction func tappedMinus(_ sender: Any) {
        SoundAnalizer.shared.baseFrequencyMinus()
    }
    
    @IBAction func tappedPlus(_ sender: Any) {
        SoundAnalizer.shared.baseFrequencyPlus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TunerViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let info = IndicatorInfo(title: "Tuner", image: UIImage(named: "tuningFork")?.withRenderingMode(.alwaysTemplate), userInfo: Mode.tuner)
        return info
    }
}
