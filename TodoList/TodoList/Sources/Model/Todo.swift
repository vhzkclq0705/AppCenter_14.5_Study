//
//  Todo.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Foundation

struct Todo: Codable {
    let name: String
    let date: String
    let contents: String
    let isCompleted: Bool
    
    init(name: String, date: String, contents: String, isCompleted: Bool) {
        self.name = name
        self.date = date
        self.contents = contents
        self.isCompleted = isCompleted
    }
}
