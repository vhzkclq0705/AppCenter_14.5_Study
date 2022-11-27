//
//  Response.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import Foundation

struct Response: Codable {
    let success: Bool
    let token: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        token = (try? values.decode(String.self, forKey: .token)) ?? ""
    }
}
