//
//  DataModel.swift
//  Networking
//
//  Created by 권오준 on 2022/11/13.
//

import Foundation

struct DataModelArray: Codable {
    let models: [DataModel]
}

struct DataModel: Codable {
    let name: String
    let avatar: String
    let job: String
    let age: Int
}
