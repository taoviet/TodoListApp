//
//  User.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
import ObjectMapper

class UserLogined : NSObject, NSCoding {
    var id: String?
    var ttl: Int?
    var userId: Int?
    
    init(id : String? , ttl : Int? , userId :Int? ) {
        self.id = id
        self.ttl = ttl
        self.userId = userId
    }
    
    override init() {}
    
    required init(coder decoder: NSCoder) {
        super.init()
        id = decoder.decodeObject(forKey: "id") as? String
        ttl = decoder.decodeObject(forKey: "ttl") as? Int
        userId = decoder.decodeObject(forKey: "userId") as? Int
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(ttl, forKey: "ttl")
        aCoder.encode(userId, forKey: "userId")
    }
    
}
