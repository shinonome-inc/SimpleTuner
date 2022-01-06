//
//  NotificationName.swift
//  guitarTuner
//
//  Created by Etsushi Otani on 2022/01/06.
//  Copyright © 2022 大谷悦志. All rights reserved.
//

import Foundation

enum NotificationName: String {
    case didChangeThemeColor
}

extension Notification.Name {
    static let didChangeThemeColor = NotificationName.didChangeThemeColor.name
}

extension NotificationName {
    var name: Notification.Name {
        let name = "\(NotificationCenter.default).\(rawValue)"
        return Notification.Name(rawValue: name)
    }
}
