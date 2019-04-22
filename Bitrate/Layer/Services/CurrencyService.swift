//
//  CurrencyRequest.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation
import RealmSwift

enum CurrencyService {
    
    static func fetchCurrency(on finish: @escaping(Bool, Error?) -> Void) {
        RequestManager.shared.execute(CurrencyRequest.currences()) { (result:RateList?, error: Error?) in
            
            if let result = result {
                var currencies = [Currency]()
                let mirror = Mirror(reflecting: result)
                for item in mirror.children {
                    if let name: String = item.label, let rate:Rate = item.value as? Rate, let buy = rate.buy, let sell = rate.sell {
                        let currency = Currency()
                        currency.name = name
                        currency.last = rate.last ?? 0.0
                        currency.buy = buy
                        currency.sell = sell
                        currency.symbol = rate.symbol ?? ""
            
                        currencies.append(currency)
                    }
                }
                
                let realm = try! Realm()
                
                try! realm.write {
                    realm.delete(realm.objects(Currency.self))
                }
                try! realm.write {
                    realm.add(currencies)
                }
                
                
                
                finish(true,nil)
            }
            if let error = error {
                finish(false,error)
            }
            
         }
       }
}
