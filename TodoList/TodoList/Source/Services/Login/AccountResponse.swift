//
//  AccountResponse.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
import ObjectMapper

class AccountResponse: BaseResponse {
    
    var id: String?
    var ttl: Int?
    var userId: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        ttl <- map["ttl"]
        userId <- map["userId"]
    }
}
