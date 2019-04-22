//
//  Rate.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//
import Foundation
import RealmSwift

struct RateList: Codable{
    let USD: Rate?
    let AUD: Rate?
    let BRL: Rate?
    let CAD: Rate?
    let CHF: Rate?
    let CLP: Rate?
    let CNY: Rate?
    let DKK: Rate?
    let EUR: Rate?
    let GBP: Rate?
    let HKD: Rate?
    let INR: Rate?
    let ISK: Rate?
    let JPY: Rate?
    let KRW: Rate?
    let NZD: Rate?
    let PLN: Rate?
    let RUB: Rate?
    let SEK: Rate?
    let SGD: Rate?
    let THB: Rate?
    let TWD: Rate?
}


struct Rate: Codable {
    let last: Float?
    let buy: Float?
    let sell: Float?
    let symbol: String?
}

class Currency: Object {
    @objc dynamic var name = ""
    @objc dynamic var last: Float = 0.0
    @objc dynamic var buy: Float = 0.0
    @objc dynamic var sell: Float = 0.0
    @objc dynamic var symbol = ""
}

