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
    private init() {}
    
    private let color = BehaviorRelay<BaseColor>(value: .blue)
    private let baseFrequency = BehaviorRelay<Int>(value: 440)
    
    var colorEvent: Observable<BaseColor> { return color.asObservable() }
    var baseFrequencyEvent: Observable<Int> { return baseFrequency.asObservable() }
    
    func setColor(color: BaseColor) {
        self.color.accept(color)
    }
    
    func setBaseFrequency(baseFrequency: Int) {
        self.baseFrequency.accept(baseFrequency)
    }
}
