//
//  LoginPost.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import Foundation

struct LoginPost: Codable {
    let memberId: String
    let password: String
    
    init(id: String, password: String) {
        self.memberId = id
        self.password = password
    }
}
