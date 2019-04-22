//
//  UITableView+Utils.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 21/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation

import UIKit

extension UITableView {
   
    
    
    var showActivityIndicator: Bool {
        set {
            if newValue {
                let indicator = UIActivityIndicatorView(
                    style: .whiteLarge
                )
                indicator.color = UIColor.appDarkBlue
                backgroundView = indicator
                indicator.startAnimating()
            } else if backgroundView is UIActivityIndicatorView {
                backgroundView = nil
            }
        }
        get {
            return backgroundView is UIActivityIndicatorView
        }
    }
    
    func showNoItemsLabel(with message: String, animated: Bool = false) {
        let label = UILabel.init()
        label.font = UIFont.latoRegular(size: 18.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = message
        
        if !(backgroundView is UILabel) {
            label.alpha = 0
        }
        
        backgroundView = label
        
        if !animated || label.alpha == 1 {
            label.alpha = 1
        } else {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .beginFromCurrentState,
                animations: { label.alpha = 1 }
            )
        }
    }
    
}
