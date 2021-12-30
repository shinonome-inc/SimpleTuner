//
//  BackgroundImageView.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2020/05/19.
//  Copyright © 2020 大谷悦志. All rights reserved.
//

import UIKit

class BackgroundImageView: UIImageView {
    let defaults = UserDefaults.standard
    
    func setImage() {
        guard let image = defaults.userDefaultImage(forKey: "backgroundImage") else {
            return
        }
        self.image = image
    }
}
