//
//  Pitch.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/04/17.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import Foundation

class Pitch: CustomStringConvertible {
    
    let note: Note
    let octave: Int
    let frequency: Double
    
    private init(note: Note, octave: Int) {
        self.note = note
        self.octave = octave
        self.frequency = note.frequency * pow(2, Double(octave) - 4)
    }
    
    static let all = Array((2 ... 6).map { octave -> [Pitch] in
        Note.all.map { note -> Pitch in
            Pitch(note: note, octave: octave)
        }
    }.joined())
    
    class func nearest(_ frequency: Double) -> Pitch {
        var results = all.map { pitch -> (pitch: Pitch, distance: Double) in
            (pitch: pitch, distance: abs(pitch.frequency - frequency))
        }
        
        results.sort { $0.distance < $1.distance }
        return results.first!.pitch
    }
    
    var description: String {
        return "\(note)\(octave)"
    }
}

func ==(a: Pitch, b: Pitch) -> Bool {
    return a.description == b.description
}

func +(pitch: Pitch, offset: Int) -> Pitch {
    let all   = Pitch.all
    let index = all.index(where: { $0 == pitch })! + offset
    
    return all[(index % all.count + all.count) % all.count]
}

func -(pitch: Pitch, offset: Int) -> Pitch {
    return pitch + (-offset)
}

