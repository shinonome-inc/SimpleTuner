//
//  tuner.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/08.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import Foundation
import AudioKit
import AudioKitEX
import SoundpipeAudioKit
import RxSwift
 
class SoundAnalizer {
    
    static let shared = SoundAnalizer()
    
    fileprivate var timer: Timer?
    private let engine = AudioEngine()
    private let mic: AudioEngine.InputNode
    private let silence: Fader
    private var tracker: PitchTap!
    
    var mode: Mode = .none
    fileprivate let baseFrequencyRange = 440.0 ..< 443.0
    
    var isPlaying = false
    
    let tunerPublisher = PublishSubject<(Pitch, Double, Double, Double)>()
    let volumeMeterPublisher = PublishSubject<Double>()
    
    private init() {
        guard let input = engine.input else {
                  fatalError("faield to start AudioKit")
              }
        print(Pitch.baseFrequency)
        mic = input
        let tappableNodeA = Fader(mic)
        let tappableNodeB = Fader(tappableNodeA)
        let tappableNodeC = Fader(tappableNodeB)
        silence = Fader(tappableNodeC, gain: 0)
        engine.output = silence
        tracker = PitchTap(mic) { [weak self] frequency, amplitude in
            DispatchQueue.main.async {
                switch self?.mode {
                case .tuner:
                    self?.didTrackFrequency(frequency: Double(frequency[0]), amplitude: Double(amplitude[0]))
                case .volume:
                    self?.didTrackAmplitude(amplitude: Double(amplitude[0]))
                default: break
                }
            }
        }
    }
    
    //share method
    
    func start() {
        do{
            try engine.start()
            tracker.start()
            isPlaying = true
            print("##### start AudioKit #####")
        }catch{
            fatalError("failed to start AudioKit")
        }
    }
    
    func stop() {
        engine.stop()
        isPlaying = false
    }
    
    func didTrackFrequency(frequency: Double, amplitude: Double) {
        let pitch = Pitch.nearest(frequency)
        let distance = frequency - pitch.frequency
        tunerPublisher.on(.next((pitch, distance, amplitude, frequency)))
    }
    
    func baseFrequencyPlus() {
        guard baseFrequencyRange.contains(Pitch.baseFrequency + 1) else {
            print("##### Over BaseFrequency Range #####")
            return
        }
        Pitch.baseFrequency += 1
        Pitch.renewAll()
        UserInfo.shared.setBaseFrequency(baseFrequency: Pitch.baseFrequency)
    }
    
    func baseFrequencyMinus() {
        guard baseFrequencyRange.contains(Pitch.baseFrequency - 1) else {
            print("##### Over BaseFrequency Range #####")
            return
        }
        Pitch.baseFrequency -= 1
        Pitch.renewAll()
        UserInfo.shared.setBaseFrequency(baseFrequency: Pitch.baseFrequency)
    }
    
    private func didTrackAmplitude(amplitude: Double) {
        let base = 0.0001
        let dB = 20 * log10(amplitude / base)
        guard amplitude > 0 else {
            print("amplitude is 0 ")
            return
        }
        volumeMeterPublisher.on(.next(dB))
    }
}	

enum Mode {
    case tuner
    case metro
    case volume
    case none
}
