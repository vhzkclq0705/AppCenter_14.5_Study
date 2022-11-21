//
//  LoginPost.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import Foundation

struct LoginPost: Encodable {
    let id: String
    let password: String
    
    init(id: String, password: String) {
        self.id = id
        self.password = password
    }
}
