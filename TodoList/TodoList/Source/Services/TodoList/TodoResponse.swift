//
//  TodoResponse.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
import ObjectMapper

class TodoResponse: Mappable {
    
    var title: String?
    var complete: Bool?
    var id: Int?
    var accountId: Int?
    var count: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        complete <- map["complete"]
        id <- map["id"]
        accountId <- map["accountId"]
        count <- map["count"]
    }
}
