//
//  ServiceAPI.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Alamofire
import Foundation

fileprivate func networking<Parameter: Codable, Model: Codable>(
    address: String,
    method: HTTPMethod,
    parameter: Parameter,
    model: Model.Type,
    completion: @escaping (Model?) -> Void)
{
    guard let url = URL(string: baseURL + address) else {
        print("URL Error")
        return
    }
    let headers: HTTPHeaders = [
        "X-AUTH-TOKEN": LoginManager.shared.token,
        "Content-Type": "application/json"
    ]
    let parameter = method == .get || method == .delete ? nil : parameter
    
    AF.request(
        url,
        method: method,
        parameters: parameter,
        encoder: JSONParameterEncoder.default,
        headers: headers)
    .validate(statusCode: 200...500)
    .responseDecodable(of: Model.self) { response in
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
    
    static func signUp(
        _ parameter: SignUp,
        completion: @escaping (Bool) -> Void)
    {
        networking(
            address: Address.signUp.url,
            method: .post,
            parameter: parameter,
            model: Response.self) { response in
                if let response = response,
                   response.success {
                    print("SignUp succeessed!")
                    completion(true)
                } else {
                    print("SignUp failed!")
                    completion(false)
                }
            }
    }
    
    static func login(
        _ parameter: Login,
        completion: @escaping (Bool) -> Void)
    {
        networking(
            address: Address.login.url,
            method: .post,
            parameter: parameter,
            model: Response.self) { response in
                if let response = response,
                   response.success {
                    print("Login succeessed!")
                    LoginManager.shared.token = response.token
                    print("Token: \(response.token)")
                    completion(true)
                } else {
                    print("Login failed!")
                    completion(false)
                }
            }
    }
    
    static func fetchAllMember(completion: @escaping ([Member]) -> Void) {
        networking(
            address: Address.allMember.url,
            method: .get,
            parameter: NonePost(),
            model: [Member].self) { members in
                if let members = members {
                    print("Fetch succeessed!")
                    completion(members)
                } else {
                    print("Fetch failed!")
                    completion([])
                }
            }
    }
    
    static func fetchOneMember(
        _ id: Int,
        completion: @escaping ([Member]) -> Void)
    {
        networking(
            address: Address.member.url + "\(id)",
            method: .get,
            parameter: NonePost(),
            model: [Member].self) { members in
                if let members = members {
                    print("Fetch succeessed!")
                    completion(members)
                } else {
                    print("Fetch failed!")
                    completion([])
                }
            }
    }
    
    static func updateMember(
        _ id: Int,
        _ update: UpdateMember,
        completion: @escaping (Bool) -> Void)
    {
        networking(
            address: Address.updateMember.url + "\(id)",
            method: .patch,
            parameter: update,
            model: Response.self) { response in
                if response != nil {
                    print("Update succeessed!")
                    completion(true)
                } else {
                    print("Update failed!")
                    completion(false)
                }
            }
    }
    
    static func deleteMember(
        _ id: Int,
        completion: @escaping (Bool) -> Void)
    {
        networking(
            address: Address.deleteMember.url + "\(id)",
            method: .delete,
            parameter: NonePost(),
            model: Response.self) { response in
                if response != nil {
                    print("Delete succeessed!")
                    completion(true)
                } else {
                    print("Delete failed!")
                    completion(false)
                }
            }
    }
    
    // MARK: - Todo
    
    static func fetchAllTodos(completion: @escaping ([Todo]) -> Void) {
        networking(
            address: Address.allTodos.url,
            method: .get,
            parameter: NonePost(),
            model: [Todo].self) { todos in
                if let todos = todos {
                    print("Fetch successed!")
                    completion(todos)
                } else {
                    print("Fetch failed!")
                    completion([])
                }
            }
    }
    
    static func fetchOneTodo(
        _ id: Int,
        completion: @escaping (Todo?) -> Void)
    {
        networking(
            address: Address.todo.url + "\(id)",
            method: .get,
            parameter: NonePost(),
            model: Todo.self) { todo in
                if let todo = todo {
                    print("Fetch successed!")
                    completion(todo)
                } else {
                    print("Fetch failed!")
                    completion(nil)
                }
            }
    }
    
    static func createTodo(
        _ create: CreatTodo,
        completion: @escaping (Bool) -> Void)
    {
        networking(
            address: Address.createTodo.url,
            method: .post,
            parameter: create,
            model: Int.self) { response in
                if response != nil {
                    print("Create successed!")
                    completion(true)
                } else {
                    print("Create failed!")
                    completion(false)
                }
            }
    }
    
    static func updateTodo(
        _ id: Int,
        _ update: UpdateTodo,
        completion: @escaping (Bool) -> Void)
    {
//        networking(
//            address: Address.updateTodo.url + "\(id)",
//            method: .patch,
//            parameter: update,
//            model: Response.self) { response in
//                if let response = response,
//                   response.success {
//                    print("Update successed!")
//                    completion(true)
//                } else {
//                    print("Update failed!")
//                    completion(false)
//                }
//            }
        
        // 임시
        let headers: HTTPHeaders = [
            "X-AUTH-TOKEN": LoginManager.shared.token,
            "Content-Type": "application/json"
        ]
        
        AF.request(
            URL(string: baseURL + Address.updateTodo.url + "\(id)")!,
            method: .patch,
            parameters: update,
            encoder: JSONParameterEncoder.default,
            headers: headers)
        .validate(statusCode: 200...500)
        .responseData { response in
            switch response.result {
            case .success(_):
                if response.response?.statusCode == 200 {
                    print("Update successed!")
                    completion(true)
                } else {
                    print("Update failed!")
                    completion(false)
                }
            case .failure(let err):
                if err.localizedDescription == "Response could not be serialized, input data was nil or zero length." {
                    print("Update successed!")
                    completion(true)
                } else {
                    print(err.localizedDescription)
                    print("Update failed!")
                    completion(false)
                }
            }
        }
    }
    
    static func deleteTodo(
        _ id: Int,
        completion: @escaping (Bool) -> Void)
    {
//        networking(
//            address: Address.deleteTodo.url + "\(id)",
//            method: .delete,
//            parameter: NonePost(),
//            model: Response.self) { response in
//                if response != nil {
//                    print("Delete successed!")
//                    completion(true)
//                } else {
//                    print("Delete failed!")
//                    completion(false)
//                }
//            }
        
        // 임시
        let headers: HTTPHeaders = [
            "X-AUTH-TOKEN": LoginManager.shared.token,
            "Content-Type": "application/json"
        ]
        
        AF.request(
            URL(string: baseURL + Address.deleteTodo.url + "\(id)")!,
            method: .delete,
            headers: headers)
        .validate(statusCode: 200...500)
        .responseData { response in
            switch response.result {
            case .success(_):
                if response.response?.statusCode == 200 {
                    print("Delete successed!")
                    completion(true)
                } else {
                    print("Delete failed!")
                    completion(false)
                }
            case .failure(let err):
                if err.localizedDescription == "Response could not be serialized, input data was nil or zero length." {
                    print("Delete successed!")
                    completion(true)
                } else {
                    print(err.localizedDescription)
                    print("Delete failed!")
                    completion(false)
                }
            }
        }
    }
    
}
