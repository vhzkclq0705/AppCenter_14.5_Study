//
//  LoginResponse.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = (try? values.decode(String.self, forKey: .token)) ?? ""
    }
}
