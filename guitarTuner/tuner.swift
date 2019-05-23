//
//  tuner.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/08.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import Foundation
import AudioKit

protocol TunerDelegate : class {
    //pitchは一番近い音階、distanceは実際の周波数とその音階の周波数との差、amplitudeは音量
    func tunerDidMesure(pitch: Pitch, distance: Double, amplitude: Double, frequency: Double)
}

    //NSObjectは全てのクラスに継承出来る大元みたいなやつ。
class Tuner: NSObject {
    weak var delegate: TunerDelegate?
    
    /* Private instance variables. */
    fileprivate var timer: Timer?
    fileprivate let microphone: AKMicrophone?
    fileprivate let tracker: AKFrequencyTracker
    fileprivate let silence: AKBooster
    
    override init() {
        microphone = AKMicrophone()
        tracker = AKFrequencyTracker(microphone)
        silence = AKBooster(tracker, gain:0)
        
    }
    
    func startTuner() {
        //チューナー起動
        AudioKit.output = silence
        do{
            try AudioKit.start()
        }catch{
            print("failed to start AudioKit")
            return
        }
        //タイマー作成
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(Tuner.tick), userInfo: nil, repeats: true)
    }
    
    func stopTuner() {
        //チューナー終了
        do{
            try AudioKit.stop()
        }catch{
            print("failed to stop AudioKit")
            return
        }
        timer?.invalidate()
    }
    
    //周波数と音の振幅を取得して音階やどれだけずれてるかを計算。
    @objc func tick() {
        
        let frequency = Double(tracker.frequency)
        let amplitude = Double(tracker.amplitude)
        
        let pitch = Pitch.nearest(frequency)
        
        let distance = frequency - pitch.frequency
        
        self.delegate?.tunerDidMesure(pitch: pitch, distance: distance, amplitude: amplitude, frequency: frequency)
        
        
    }
    
}	
