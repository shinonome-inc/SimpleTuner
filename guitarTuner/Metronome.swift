//
//  Metronome.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/08/24.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import AudioKit

class Metronome: NSObject {
    
    fileprivate let metronome = AKMetronome()
    
    override init() {
        metronome.tempo = 60
        metronome.subdivision = 4
        metronome.frequency1 = 2000
        metronome.frequency2 = 1000
        
    }
    
    func startMetro() {
        metronome.start()
        AudioKit.output = metronome
        do{
            try AudioKit.start()
        }catch {
            print("failed to start metronome")
        }
    }
    
    func stopMetro() {
        do{
            try AudioKit.stop()
        }catch {
            print("failed to stop metronome")
        }
    }
    
}
