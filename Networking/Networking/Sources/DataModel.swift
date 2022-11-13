//
//  DataModel.swift
//  Networking
//
//  Created by 권오준 on 2022/11/13.
//

import Foundation

struct DataModelArray {
    let models: [DataModel]
}

struct DataModel: Codable {
    let id: Int
    let name: String
    let avatar: String
    let job: String
    let age: Int
}
