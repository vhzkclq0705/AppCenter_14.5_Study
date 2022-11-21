//
//  ServiceAPI.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Alamofire
import Foundation

fileprivate func networking<T: Decodable>(
    address: Address,
    data: Data?,
    model: T.Type,
    completion: @escaping (T?) -> Void)
{
    guard let url = URL(string: baseURL + address.url) else {
        print("URL Error")
        return
    }
    
    let headers: HTTPHeaders = [
        "X-AUTH-TOKEN": LoginManager.shared.token,
        "Content-Type": "application/json"
    ]
    
    var request = try! URLRequest(url: url, method: address.method, headers: headers)
    request.httpBody = data
    
    AF.request(request)
        .validate(statusCode: 200...500)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let model):
                completion(model)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
}

final class API {
    
    // MARK: - Member
    
    static func signUp(_ model: SignUpPost, completion: @escaping (Bool) -> Void) {
        guard let data = try? JSONEncoder().encode(model) else {
            return
        }
        
        networking(address: .login, data: data, model: DefaultResponse.self) { model in
            if model != nil {
                print("SignUp succeessed!")
                completion(true)
            } else {
                print("SignUp failed!")
                completion(false)
            }
        }
    }
    
    static func login(_ model: LoginPost, completion: @escaping (Bool) -> Void) {
        guard let data = try? JSONEncoder().encode(model) else {
            return
        }
        
        networking(address: .login, data: data, model: LoginResponse.self) { model in
            if let model = model {
                print("Login succeessed!")
                LoginManager.shared.token = model.token
                print("Token: \(model.token)")
                completion(true)
            } else {
                print("Login failed!")
                completion(false)
            }
        }
    }
    
    // MARK: - Todo
    
    static func fetchAllTodos(completion: @escaping ([Todo]) -> Void) {
        networking(address: .allTodos, data: nil, model: [Todo].self) { model in
            if let model = model {
                print("Fetch successed!")
                completion(model)
            } else {
                print("Fetch failed!")
                completion([])
            }
        }
    }
}
