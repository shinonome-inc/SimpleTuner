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
        self.color.accept(color)
    }
    
    private let color = BehaviorRelay<BaseColor>(value: .blue)
    private let baseFrequency = BehaviorRelay<Int>(value: 440)
    private let tempo = BehaviorRelay<Double>(value: 120)
    
    var colorEvent: Observable<BaseColor> { return color.asObservable() }
    var baseFrequencyEvent: Observable<Int> { return baseFrequency.asObservable() }
    var tempoEvent: Observable<Double> { return tempo.asObservable() }
    
    func setColor(color: BaseColor) {
        self.color.accept(color)
        setColorUserDefaults(color: color, key: "baseColor")
    }
    
    func setBaseFrequency(baseFrequency: Int) {
        self.baseFrequency.accept(baseFrequency)
    }
    
    func setTempo(tempo: Double) {
        self.tempo.accept(tempo)
    }
    
    private func setColorUserDefaults(color: BaseColor, key: String) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? jsonEncoder.encode(color) else {
            return
        }
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    private func getColorUserDefaults(key: String) ->BaseColor{
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = UserDefaults.standard.data(forKey: key),
              let color = try? jsonDecoder.decode(BaseColor.self, from: data) else {
            return .blue
        }
        return color
    }
}
