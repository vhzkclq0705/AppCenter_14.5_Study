//
//  Member.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Foundation

struct Member: Codable {
    let id: Int
    let name: String
    let age: Int
    let email: String
    let todos: [Todo]
    
    enum CodingKeys: String, CodingKey {
        case todos = "toDoDtoList"
        case id, name, age, email
    }
}
