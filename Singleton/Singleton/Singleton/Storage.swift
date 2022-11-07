//
//  Storage.swift
//  Singleton
//
//  Created by 권오준 on 2022/11/07.
//

import Foundation

class Storage {
    
    // 싱글톤 패턴을 위한 변수
    
    static let shared = Storage()
    
    // 추가 인스턴스 생성을 막기 위한 init
    
    private init () {
        self.id = ""
        self.password = ""
        self.age = ""
    }
    
    // MARK: - Property
    
    var id: String?
    var password: String?
    var age: String?
    
}
