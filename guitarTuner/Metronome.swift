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
    fileprivate let metronome = AKMetronome()
    var isActivated: Bool = false
    
    
    override init() {
        metronome.tempo = 120
        metronome.subdivision = 4
        metronome.frequency1 = 2000
        metronome.frequency2 = 1000
    }
    
    func startMetro() {
        metronome.callback = {
            self.delegate?.metronomeDidBeat()
        }
        metronome.start()
        AudioKit.output = metronome
        do{
            try AudioKit.start()
            isActivated = true
        }catch {
            print("failed to start metronome")
        }
    }
    
    func stopMetro() {
        do{
            try AudioKit.stop()
            isActivated = false
        }catch {
            print("failed to stop metronome")
        }
    }
    
    func tempoPlus1() {
        metronome.tempo += 1
    }
    
    func tempoMinus1() {
        metronome.tempo -= 1
    }
    
    func getTempo() ->Double{
        return metronome.tempo
    }
    
    func getBeatNumber() ->Int{
        return metronome.subdivision
    }
    
    
}
