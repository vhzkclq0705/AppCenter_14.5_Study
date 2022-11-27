//
//  SignUp.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import Foundation

struct SignUp: Codable {
    let age: Int
    let email: String
    let memberId: String
    let name: String
    let password: String
    let role: String
    
    // ADMIN
    init(
        age: Int,
        email: String,
        memberId: String,
        name: String,
        password: String)
    {
        self.age = age
        self.email = email
        self.memberId = memberId
        self.name = name
        self.password = password
        self.role = "ADMIN"
    }
    
}
