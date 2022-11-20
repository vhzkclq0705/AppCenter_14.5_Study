//
//  Todo.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Foundation

struct Todo: Codable {
    let contents: String
    let id: Int
    let isCompleted: Bool
}
