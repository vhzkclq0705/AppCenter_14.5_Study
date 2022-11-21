//
//  DefaultResponse.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import Foundation

struct DefaultResponse: Codable {
    let response: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = (try? container.decode(String.self, forKey: .response)) ?? ""
    }
}
