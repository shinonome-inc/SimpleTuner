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
    var isActivated: Bool = false
    
    
    override init() {
        metronome.tempo = 120
        metronome.subdivision = 4
        metronome.frequency1 = 2000
        metronome.frequency2 = 1000
    }
    
    func startMetro() {
        stopMetro()
        metronome.callback = {
            self.delegate?.metronomeDidBeat()
        }
        metronome.start()
        AKManager.output = metronome
        do{
            try AKManager.start()
            isActivated = true
        }catch {
            print("failed to start metronome")
        }
    }
    
    func stopMetro() {
        do{
            try AKManager.stop()
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
