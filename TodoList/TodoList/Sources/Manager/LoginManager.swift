//
//  LoginManager.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Foundation

final class LoginManager {
    
    // MARK: - Init(Singleton)
    
    static let shared = LoginManager()
    
    private init() {}
    
    // MARK: - Property
    
    var token: String = "" {
        didSet {
            saveToken()
        }
    }
    
    // MARK: - Func
    
    private func saveToken() {
        UserDefaults.standard.set(token, forKey: "token")
        print("save")
    }
    
    func loadToken() {
        token = UserDefaults.standard.string(forKey: "token") ?? ""
        print("load")
    }
    
}
