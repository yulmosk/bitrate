//
//  UINavBar+AppStyle.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewWillLayoutSubviews() {
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationBar.layer.shadowRadius = 4
        
        let path = UIBezierPath.init(rect: navigationBar.bounds)
        navigationBar.layer.shadowPath = path.cgPath
    }
}
