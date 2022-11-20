//
//  Response.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Foundation

struct Response: Codable {
    let id: Int
    let content: String
    let isCompleted: Bool
    let member: Member
}
