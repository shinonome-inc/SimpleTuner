//
//  tuner.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/08.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import Foundation
import AudioKit

protocol TunerDelegate: class {
    //pitchは一番近い音階、distanceは実際の周波数とその音階の周波数との差、amplitudeは音量
    func tunerDidMesure(pitch: Pitch, distance: Double, amplitude: Double, frequency: Double)
}

protocol SoundMaterDelegate: class {
    func soundMaterDidMesure(dB: Double)
}

    //NSObjectは全てのクラスに継承出来る大元みたいなやつ。
class SoundAnalizer {
    
    static let shared = SoundAnalizer()
    
    weak var tunerDelegate: TunerDelegate?
    weak var soundMaterDelegate: SoundMaterDelegate?
    
    /* Private instance variables. */
    fileprivate var timer: Timer?
    fileprivate let microphone: AKMicrophone?
    fileprivate let frequencyTracker: AKFrequencyTracker
    fileprivate let amplitudeTracker: AKAmplitudeTracker
    fileprivate let frequencySilence: AKBooster
    fileprivate let amplitudeSilence: AKBooster
    
    private init() {
        microphone = AKMicrophone()
        frequencyTracker = AKFrequencyTracker(microphone)
        frequencySilence = AKBooster(frequencyTracker, gain: 0)
        amplitudeTracker = AKAmplitudeTracker(microphone)
        amplitudeSilence = AKBooster(amplitudeTracker, gain: 0)
    }
    
    func startTuner() {
        stop()
        AKManager.output = frequencySilence
        do{
            try AKManager.start()
        }catch{
            print("failed to start AudioKit")
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(SoundAnalizer.tick), userInfo: nil, repeats: true)
    }
    
    func startSoundMater() {
        stop()
        AKManager.output = amplitudeSilence
        do{
            try AKManager.start()
        }catch{
            print("failed to start AudioKit")
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(SoundAnalizer.getAmplitude), userInfo: nil, repeats: true)
    }
    
    func stop() {
        do{
            try AKManager.stop()
        }catch{
            print("aleady stop AudioKit")
            return
        }
        timer?.invalidate()
    }
    
    //周波数と音の振幅を取得して音階やどれだけずれてるかを計算。
    @objc func tick() {
        let frequency = Double(frequencyTracker.frequency)
        let amplitude = Double(frequencyTracker.amplitude)
        let pitch = Pitch.nearest(frequency)
        let distance = frequency - pitch.frequency
        
        self.tunerDelegate?.tunerDidMesure(pitch: pitch, distance: distance, amplitude: amplitude, frequency: frequency)
    }
    
    @objc func getAmplitude() {
        let base = 0.0001
        let amplitude = Double(amplitudeTracker.amplitude)
        let dB = 20 * log10(amplitude / base)
        print(amplitude)
        guard amplitude > 0 else {
            print("amplitude is 0 ")
            return
        }
        self.soundMaterDelegate?.soundMaterDidMesure(dB: dB)
    }
}	
