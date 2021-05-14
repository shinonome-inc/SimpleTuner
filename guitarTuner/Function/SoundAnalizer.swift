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

protocol MetronomeDelegate: class {
    func metronomeDidBeat(currentBeat: Int)
}

protocol VolumeMeterDelegate: class {
    func volumeMeterDidMesure(dB: Double)
}

class SoundAnalizer {
    
    static let shared = SoundAnalizer()
    
    weak var tunerDelegate: TunerDelegate?
    weak var volumeMeterDelegate: VolumeMeterDelegate?
    weak var metronomeDelegate: MetronomeDelegate?
    
    /* Private instance variables. */
    fileprivate var timer: Timer?
    fileprivate let costomDispatchQueue: DispatchQueue
    fileprivate let microphone: AKMicrophone?
    fileprivate let frequencyTracker: AKFrequencyTracker
    fileprivate let amplitudeTracker: AKAmplitudeTracker
    fileprivate let frequencySilence: AKBooster
    fileprivate let amplitudeSilence: AKBooster
    fileprivate let metronome: AKMetronome
    fileprivate let metronomeMixer: AKMixer
    fileprivate (set) var mode: Mode
    var metronomeIsActive: Bool = false
    
    private init() {
        costomDispatchQueue = DispatchQueue(label: "com.gmail.324etsushi",qos: .userInteractive)
        microphone = AKMicrophone()
        frequencyTracker = AKFrequencyTracker(microphone)
        frequencySilence = AKBooster(frequencyTracker, gain: 0)
        amplitudeTracker = AKAmplitudeTracker(microphone)
        amplitudeSilence = AKBooster(amplitudeTracker, gain: 0)
        metronome = AKMetronome()
        metronome.tempo = 120
        metronome.subdivision = 4
        metronome.frequency1 = 2000
        metronome.frequency2 = 1000
        metronomeMixer = AKMixer(metronome)
        metronomeMixer.volume = 10
        mode = .none
        metronome.callback = {
            self.metronomeDelegate?.metronomeDidBeat(currentBeat: self.metronome.currentBeat)
        }
    }
    
    //share method
    func start() {
        do{
            try AKManager.start()
            print("##### start AudioKit #####")
        }catch{
            print("failed to start AudioKit")
            return
        }
    }
    
    func stop() {
        do{
            try AKManager.stop()
            print("##### stop AudioKit #####")
        }catch{
            print("##### aleady stop AudioKit #####")
            return
        }
    }
    
    func setMode(mode: Mode) {
        guard self.mode != mode else {
            print("##### mode is aleady setted #####")
            return
        }
        costomDispatchQueue.async {
            self.stop()
            self.mode = mode
            switch mode {
            case .tuner:
                AKManager.output = self.frequencySilence
                print("##### Mode Tuner #####")
            case .metro:
                AKManager.output = self.metronomeMixer
                print("##### Mode Metro #####")
            case .volume:
                AKManager.output = self.amplitudeSilence
                print("##### Mode Volume #####")
            case .none:
                self.stop()
                print("##### Mode None #####")
                return
            }
            self.start()
        }
        timerValidation(mode: mode)
    }
    
    func timerValidation(mode :Mode) {
        timer?.invalidate()
        switch mode {
        case .tuner:
            self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(SoundAnalizer.tick), userInfo: nil, repeats: true)
        case .volume:
            self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(SoundAnalizer.getAmplitude), userInfo: nil, repeats: true)
        default:
            return
        }
    }
    
    //tuner method
    @objc func tick() {
        let frequency = Double(frequencyTracker.frequency)
        let amplitude = Double(frequencyTracker.amplitude)
        let pitch = Pitch.nearest(frequency)
        let distance = frequency - pitch.frequency
        print(frequency)
        
        self.tunerDelegate?.tunerDidMesure(pitch: pitch, distance: distance, amplitude: amplitude, frequency: frequency)
    }
    
    //metronome method
    func startMetro() {
        metronome.start()
        metronomeIsActive = true
    }
    
    func stopMetro() {
        metronome.stop()
        metronomeIsActive = false
    }
    
    func tempoPlus1() {
        metronome.tempo += 1
        UserInfo.shared.setTempo(tempo: metronome.tempo)
    }
    
    func tempoMinus1() {
        metronome.tempo -= 1
        UserInfo.shared.setTempo(tempo: metronome.tempo)
    }
    
    func setTenpo(settedTenpo: Double) {
        metronome.tempo = settedTenpo
        UserInfo.shared.setTempo(tempo: metronome.tempo)
    }
    
    func getTempo() ->Double{
        return metronome.tempo
    }
    
    func getBeatNumber() ->Int{
        return metronome.subdivision
    }
    
    //volume meter method
    @objc func getAmplitude() {
        let base = 0.0001
        let amplitude = Double(amplitudeTracker.amplitude)
        let dB = 20 * log10(amplitude / base)
        print(amplitude)
        guard amplitude > 0 else {
            print("amplitude is 0 ")
            return
        }
        self.volumeMeterDelegate?.volumeMeterDidMesure(dB: dB)
    }
}	

enum Mode {
    case tuner
    case metro
    case volume
    case none
}
