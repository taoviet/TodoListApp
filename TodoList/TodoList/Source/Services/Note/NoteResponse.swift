//
//  NoteResponse.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
import ObjectMapper

class NoteResponse: Mappable {
    
    var text: String?
    var id: Int?
    var todoId: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        text <- map["text"]
        id <- map["id"]
        todoId <- map["todoId"]
    }
}
