//
//  BaseResponse.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//


import Foundation
import ObjectMapper

enum ResponseStatus: Int {
    case Error = 0
    case Success = 1
}

class BaseResponse: NSObject , Mappable  {
    
    var messageError: String?
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    
    func mapping(map: Map) {
        messageError <- map["error.message"]
    }
}
