//
//  User.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2021/01/06.
//  Copyright © 2021 大谷悦志. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class UserInfo {
    static let shared = UserInfo()
    private init() {
        let color = getColorUserDefaults(key: "baseColor")
        let baseFrequency = UserDefaults.standard.double(forKey: "baseFrequency")
        self.color.accept(color)
        self.baseFrequency.accept(baseFrequency)
    }
    
    private let color = BehaviorRelay<ThemeColor>(value: .blue)
    private let baseFrequency = BehaviorRelay<Double>(value: 440)
    private let tempo = BehaviorRelay<Double>(value: 120)
    
    var colorEvent: Observable<ThemeColor> { return color.asObservable() }
    var baseFrequencyEvent: Observable<Double> { return baseFrequency.asObservable() }
    var tempoEvent: Observable<Double> { return tempo.asObservable() }
    
    func setColor(color: ThemeColor) {
        self.color.accept(color)
        setColorUserDefaults(color: color, key: "baseColor")
    }
    
    func setBaseFrequency(baseFrequency: Double) {
        self.baseFrequency.accept(baseFrequency)
        UserDefaults.standard.setValue(baseFrequency, forKey: "baseFrequency")
    }
    
    func setTempo(tempo: Double) {
        self.tempo.accept(tempo)
    }
    
    private func setColorUserDefaults(color: ThemeColor, key: String) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? jsonEncoder.encode(color) else {
            return
        }
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    private func getColorUserDefaults(key: String) ->ThemeColor{
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = UserDefaults.standard.data(forKey: key),
              let color = try? jsonDecoder.decode(ThemeColor.self, from: data) else {
            return .blue
        }
        return color
    }
}
