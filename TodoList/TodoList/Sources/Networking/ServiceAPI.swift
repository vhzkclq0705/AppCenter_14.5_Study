//
//  ServiceAPI.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Alamofire
import Foundation

// T1: Request, T2: Response
fileprivate func networking<T1: Codable, T2: Codable>(
    address: Address,
    parameter: T1,
    model: T2.Type,
    completion: @escaping (T2?) -> Void)
{
    guard let url = URL(string: baseURL + address.url) else {
        print("URL Error")
        return
    }
    
    let headers: HTTPHeaders = [
        "X-AUTH-TOKEN": LoginManager.shared.token,
        "Content-Type": "application/json"
    ]
    
    AF.request(
        url,
        method: address.method,
        parameters: address.method == .get ? nil : parameter,
        encoder: JSONParameterEncoder.default,
        headers: headers)
    .validate(statusCode: 200...500)
    .responseDecodable(of: T2.self) { response in
        switch response.result {
        case .success(let model):
            if response.response?.statusCode == 200 {
                completion(model)
            } else {
                completion(nil)
            }
        case .failure(let err):
            print(err.localizedDescription)
            completion(nil)
        }
    }
}

final class API {
    
    // MARK: - Member
    
    static func signUp(_ parameter: SignUpPost, completion: @escaping (Bool) -> Void) {
        networking(
            address: .signUp,
            parameter: parameter,
            model: DefaultResponse.self) { model in
                if model != nil {
                    print("SignUp succeessed!")
                    completion(true)
                } else {
                    print("SignUp failed!")
                    completion(false)
                }
            }
    }
    
    static func login(_ parameter: LoginPost, completion: @escaping (Bool) -> Void) {
        networking(
            address: .login,
            parameter: parameter,
            model: LoginResponse.self) { model in
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
        networking(
            address: .allTodos,
            parameter: NonePost(),
            model: [Todo].self) { model in
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
