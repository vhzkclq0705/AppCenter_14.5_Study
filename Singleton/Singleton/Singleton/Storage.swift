//
//  Storage.swift
//  Singleton
//
//  Created by 권오준 on 2022/11/07.
//

import Foundation

// Sington Pattern: 특정 용도로 객체를 하나만 생성하여 공용으로 사용하고 싶을 때 사용하는 디자인 유형

// 싱글톤의 장점
// 1. 한 번의 인스턴스만 생성하므로 메모리 낭비를 방지할 수 있다.
// 2. 싱글톤 인스턴스는 전역 인스턴스로 다른 클래스들과의 자원 공유가 쉽다.
// 3. 공통된 객체를 여러개 생성해서 사용해야하는 상황에서 많이 사용한다.(쓰레드풀, 캐시, 대화상자, 로그 기록 등)

// 싱글톤의 단점
// 싱글톤 인스턴스가 너무 많은 일을 하거나 많은 데이터를 공유시킬 경우, 다른 클래스의 인스턴스들 간의 결합도가 높아져 "개방-폐쇄" 원칙을 위배하여 수정과 테스트가 어려워진다.

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
