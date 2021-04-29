//
//  Metronome.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/24.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import AudioKit

protocol MetronomeDelegate: class {
    func metronomeDidBeat()
}

class Metronome: NSObject {
    
    weak var delegate: MetronomeDelegate?
    private let metronome = AKMetronome()
    private var mixer: AKMixer!
    var isActivated: Bool = false
    
    
    override init() {
        super.init()
        metronome.tempo = 120
        metronome.subdivision = 4
        metronome.frequency1 = 2000
        metronome.frequency2 = 1000
        mixer = AKMixer(metronome)
        mixer.volume = 10
    }
    
    func startMetro() {
        stopMetro()
        metronome.callback = {
            self.delegate?.metronomeDidBeat()
        }
        AKManager.output = mixer
        do{
            try AKManager.start()
            metronome.start()
            isActivated = true
        }catch {
            print("failed to start metronome")
        }
    }
    
    func stopMetro() {
        do{
            try AKManager.stop()
            metronome.stop()
            isActivated = false
        }catch {
            print("failed to stop metronome")
        }
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
    
    
}
