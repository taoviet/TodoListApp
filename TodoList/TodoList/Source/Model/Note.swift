//
//  Note.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
struct Note {
    
    var text: String?
    var id: Int?
    var idTodo: Int?
    
    init(text: String?, id: Int?, idTodo: Int?) {
        self.text = text
        self.id = id
        self.idTodo = idTodo

    }
}
