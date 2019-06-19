//
//  ViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/05.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit


class ViewController: UIViewController,TunerDelegate{

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var pitchTextLabel: UILabel!
    @IBOutlet weak var frequencyTextLabel: UILabel!

    @IBOutlet weak var cPlusView: UIView!
    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var dView: UIView!
    @IBOutlet weak var eMinusView: UIView!
    @IBOutlet weak var eView: UIView!
    @IBOutlet weak var fPlusView: UIView!
    @IBOutlet weak var fView: UIView!
    @IBOutlet weak var gView: UIView!
    @IBOutlet weak var aMinusView: UIView!
    @IBOutlet weak var aView: UIView!
    @IBOutlet weak var bMinusView: UIView!
    @IBOutlet weak var bView: UIView!

    let frequencyLabel = UILabel()
    let pitchLabel = UILabel()
    let pitchFrequencyLabel = UILabel()
    let barLabel = UILabel()
    let gradientLayer = CAGradientLayer()
    let materView = MaterView(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))
    let arrowView = ArrowView(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))
    let tuner = Tuner()
    
    //テスト用
    let centerLine = CAShapeLayer()
    let holizenLine = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tuner.delegate = self
        tuner.startTuner()
        
        setupLayout()
        //testSetupLayout()
        
        
    }
    
    //テスト用図形レイアウト
    func testSetupLayout(){
        let centerPath = UIBezierPath()
        centerPath.move(to: CGPoint(x: self.view.bounds.width / 2, y: 0))
        centerPath.addLine(to: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height))
        
        centerLine.strokeColor = #colorLiteral(red: 0, green: 0.4253050089, blue: 0.4359070063, alpha: 0.7127255722)
        centerLine.path = centerPath.cgPath
        centerLine.lineWidth = 1.5
        self.view.layer.addSublayer(centerLine)
        
        let holizenPath = UIBezierPath()
        holizenPath.move(to: CGPoint(x: 0, y: self.view.bounds.height / 2))
        holizenPath.addLine(to: CGPoint(x: self.view.bounds.width, y: self.view.bounds.height / 2))
        
        holizenLine.strokeColor = #colorLiteral(red: 0, green: 0.4253050089, blue: 0.4359070063, alpha: 0.7127255722)
        holizenLine.path = holizenPath.cgPath
        holizenLine.lineWidth = 1.5
        self.view.layer.addSublayer(holizenLine)
    }
    
    /// レイアウト系のセットアップ
    func setupLayout() {
        
//        gradientLayer.colors = [ UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor ]
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.startPoint = CGPoint.zero
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
//        self.view.layer.addSublayer(gradientLayer)

        materView.frame = CGRect(x: (self.view.bounds.width - 300) / 2, y: baseView.frame.origin.y + 75, width: 300, height: 300)
        self.view.addSubview(materView)

        arrowView.frame = CGRect(x: (self.view.bounds.width - 300) / 2, y: baseView.frame.origin.y + 75, width: 300, height: 300)
        arrowView.makeArrowLayer()
        self.view.addSubview(arrowView)
        
        /*barLabel.textAlignment = NSTextAlignment.center
        barLabel.numberOfLines = 1
        barLabel.font = UIFont.systemFont(ofSize: 50)
        barLabel.translatesAutoresizingMaskIntoConstraints = false
        barLabel.textColor = UIColor.white
        barLabel.text = "/"
        self.view.addSubview(barLabel)
        
        barLabel.rightAnchor.constraint(equalTo: materView.centerXAnchor).isActive = true
        barLabel.topAnchor.constraint(equalTo: materView.bottomAnchor).isActive = true
        barLabel.widthAnchor.constraint(equalTo: materView.widthAnchor, multiplier: 0.2).isActive = true
        barLabel.heightAnchor.constraint(equalTo: materView.heightAnchor, multiplier: 0.3).isActive = true*/
        
//        frequencyLabel.textAlignment = NSTextAlignment.center
//        frequencyLabel.numberOfLines = 1
//        frequencyLabel.font = UIFont.systemFont(ofSize: 50)
//        frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
//        frequencyLabel.textColor = UIColor.red
//        self.view.addSubview(frequencyLabel)

//        frequencyLabel.rightAnchor.constraint(equalTo: materView.centerXAnchor).isActive = true
//        frequencyLabel.topAnchor.constraint(equalTo: materView.bottomAnchor).isActive = true
//        frequencyLabel.widthAnchor.constraint(equalTo: materView.widthAnchor, multiplier: 0.6).isActive = true
//        frequencyLabel.heightAnchor.constraint(equalTo: materView.heightAnchor, multiplier: 0.3).isActive = true

//        pitchLabel.textAlignment = NSTextAlignment.center
//        pitchLabel.numberOfLines = 1
//        pitchLabel.font = UIFont(name: "HiraMinProN-W3", size: 100)
//        pitchLabel.translatesAutoresizingMaskIntoConstraints = false
//        pitchLabel.textColor = UIColor.blue
//        self.view.addSubview(pitchLabel)

//        pitchLabel.centerXAnchor.constraint(equalTo: materView.centerXAnchor).isActive = true
//        pitchLabel.topAnchor.constraint(equalTo: materView.centerYAnchor).isActive = true
//        pitchLabel.widthAnchor.constraint(equalTo: materView.widthAnchor, multiplier: 0.7).isActive = true
//        pitchLabel.heightAnchor.constraint(equalTo: materView.heightAnchor, multiplier: 0.5).isActive = true
//
//        pitchFrequencyLabel.textAlignment = NSTextAlignment.center
//        pitchFrequencyLabel.numberOfLines = 1
//        pitchFrequencyLabel.font = UIFont.systemFont(ofSize: 25)
//        pitchFrequencyLabel.translatesAutoresizingMaskIntoConstraints = false
//        pitchFrequencyLabel.textColor = UIColor.white
//        self.view.addSubview(pitchFrequencyLabel)
//
//        pitchFrequencyLabel.leftAnchor.constraint(equalTo: materView.centerXAnchor).isActive = true
//        pitchFrequencyLabel.bottomAnchor.constraint(equalTo: frequencyLabel.bottomAnchor).isActive = true
//        pitchFrequencyLabel.widthAnchor.constraint(equalTo: materView.widthAnchor, multiplier: 0.5).isActive = true
//        pitchFrequencyLabel.heightAnchor.constraint(equalTo: frequencyLabel.heightAnchor, multiplier: 0.8).isActive = true
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
        let frequencyText = String(format: "%.1f", frequency)
        let pitchFrequencyText = String(format: "%.1f", pitch.frequency)
        frequencyTextLabel.text = frequencyText
        pitchTextLabel.text = pitchFrequencyText
        headerLabel.text = "\(pitch.note)"
        arrowView.moveArrowLayer(pitch: pitch, frequency: frequency)
        
        if fabs(distance) < 0.1 {
            headerLabel.textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }else{
            headerLabel.textColor = UIColor.white
        }

        setPitchColor(from: "\(pitch.note)")
    }

    @IBAction func didTapBArButtonItem(_ sender: Any) {

        print("foo")
    }

    var previousValue = ""

    func setPitchColor(from pitch: String) {

        guard previousValue != pitch else {
            return
        }
        previousValue = pitch

        UIView.animate(withDuration: 0.1) { [unowned self] in
            let views = [self.cView,
                         self.cPlusView,
                         self.dView,
                         self.eMinusView,
                         self.eView,
                         self.fPlusView,
                         self.fView,
                         self.gView,
                         self.aMinusView,
                         self.aView,
                         self.bView,
                         self.bMinusView]
            _ = views.map({ $0?.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1) })

            switch pitch {
            case "C": self.cView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "C♯": self.cPlusView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "D": self.dView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "E♭": self.eMinusView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "E": self.eView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "F": self.fView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "F♯": self.fPlusView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "G": self.gView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "A♭": self.aMinusView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "A": self.aView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "B♭": self.bMinusView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case "B": self.bView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            default: return
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

