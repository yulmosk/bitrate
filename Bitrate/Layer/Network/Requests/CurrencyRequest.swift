//
//  CurrencyRequest.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation

import Alamofire

enum CurrencyRequest: URLRequestConvertible {
    case currences()
    
    var method: HTTPMethod {
        switch self {
        case .currences:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .currences:
            return "/ticker"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Api.host.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return request
    }
    
    
}
