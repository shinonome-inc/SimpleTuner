//
//  ViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/05.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit


class ViewController: UIViewController,TunerDelegate{
    
    let frequencyLabel = UILabel()
    let pitchLabel = UILabel()
    let pitchFrequencyLabel = UILabel()
    let materView = MaterView(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))
    let tuner = Tuner()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tuner.delegate = self
        tuner.startTuner()
        setupLayout()
        
    }
    
    
    /// レイアウト系のセットアップ
    func setupLayout() {

        materView.frame = CGRect(x: (self.view.bounds.width - 300) / 2, y: (self.view.bounds.height - 300) / 2, width: 300, height: 300)

        self.view.addSubview(materView)

        frequencyLabel.textAlignment = NSTextAlignment.center
        frequencyLabel.numberOfLines = 1
        frequencyLabel.font = UIFont.systemFont(ofSize: 22)
        frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(frequencyLabel)
        
        frequencyLabel.leftAnchor.constraint(equalTo: materView.centerXAnchor).isActive = true
        frequencyLabel.topAnchor.constraint(equalTo: materView.bottomAnchor).isActive = true
        frequencyLabel.widthAnchor.constraint(equalTo: materView.widthAnchor, multiplier: 0.5).isActive = true
        frequencyLabel.heightAnchor.constraint(equalTo: materView.heightAnchor, multiplier: 0.3).isActive = true

        pitchLabel.textAlignment = NSTextAlignment.center
        pitchLabel.numberOfLines = 1
        pitchLabel.font = UIFont.systemFont(ofSize: 46)
        pitchLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pitchLabel)

        pitchLabel.centerXAnchor.constraint(equalTo: materView.centerXAnchor).isActive = true
        pitchLabel.topAnchor.constraint(equalTo: materView.centerYAnchor).isActive = true
        pitchLabel.widthAnchor.constraint(equalTo: materView.widthAnchor, multiplier: 0.5).isActive = true
        pitchLabel.heightAnchor.constraint(equalTo: materView.heightAnchor, multiplier: 0.5).isActive = true

        pitchFrequencyLabel.textAlignment = NSTextAlignment.center
        pitchFrequencyLabel.numberOfLines = 1
        pitchFrequencyLabel.font = UIFont.systemFont(ofSize: 60)
        pitchFrequencyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pitchFrequencyLabel)

        pitchFrequencyLabel.leftAnchor.constraint(equalTo: materView.centerXAnchor).isActive = true
        pitchFrequencyLabel.topAnchor.constraint(equalTo: materView.bottomAnchor).isActive = true
        pitchFrequencyLabel.widthAnchor.constraint(equalTo: materView.widthAnchor, multiplier: 0.5).isActive = true
        pitchFrequencyLabel.heightAnchor.constraint(equalTo: materView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    /// メジャーの更新
    ///
    /// - Parameters:
    ///   - pitch: Pitch
    ///   - distance: 距離
    ///   - amplitude: 振幅
    ///   - frequency: 周波数
    func tunerDidMesure(pitch: Pitch, distance: Double, amplitude: Double, frequency: Double) {
        if amplitude < 0.01 {
            return
        }
        frequencyLabel.text = "\(frequency)"
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

