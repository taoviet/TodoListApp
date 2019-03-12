//
//  Todo.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation


struct Todo  {
    
    var title: String?
    var complete: Bool?
    var id: Int?
    var accountId: Int?
    
    init(title: String? , complete: Bool? , id:Int? , accountId: Int? ) {
        self.title = title
        self.complete = complete
        self.id = id
        self.accountId = accountId
    }
}
