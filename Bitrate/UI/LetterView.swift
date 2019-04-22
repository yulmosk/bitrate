//
//  LettersView.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//


import UIKit

final class LetterView: UIView {
    let label = UILabel()
    
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
        
        backgroundColor = UIColor.appDarkBlue
        label.frame = CGRect(x:0, y:0, width:bounds.width, height:bounds.height)
        label.font = UIFont.latoBold(size: bounds.height / 3)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "USD"
        layer.cornerRadius = frame.size.width / 2
        self.addSubview(label)
        
        layoutIfNeeded()
    }
    
    public func setLetters(_ letters:String){
        label.text = letters
    }
    
}







