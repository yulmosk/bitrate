//
//  AppAppearence.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit

enum AppAppearance {
    static func setup() {
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.latoBold(size: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.appDarkBlue
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.white
        
    }
}

