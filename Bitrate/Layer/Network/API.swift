//
//  API.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation

enum Api {
    static let host = "https://blockchain.info"
    
}

protocol ResponseProcessor {
    func process(on finish:() -> Void)
}
