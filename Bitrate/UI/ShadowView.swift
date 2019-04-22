//
//  ShadowView.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit

final class ShadowView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        baseInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseInit()
    }
    
    
    private func baseInit() {
        layer.cornerRadius = 4
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: -8, height: 2)
        layer.shadowRadius = 4
        
        let path = UIBezierPath.init(rect: bounds)
        layer.shadowPath = path.cgPath
        
        
        
        
        layoutIfNeeded()
    }
}







