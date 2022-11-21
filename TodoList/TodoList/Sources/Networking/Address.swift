//
//  Address.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import Alamofire
import Foundation

enum Address {
    // Login
    case signUp
    case login
    // Member
    case allMember
    case member
    case updateMember
    case deleteMember
    // Todo
    case allTodos
    case todo
    case createTodo
    case updateTodo
    case deleteTodo
}

extension Address {
    var url: String {
        switch self {
            // Login
        case .signUp: return "members/sign-up"
        case .login: return "members/sign-in"
            
            // Member
        case .allMember: return "members"
        case .member,
                .updateMember,
                .deleteMember:
            return "members/" // + memberID
            
            // Todo
        case .allTodos,
                .createTodo:
            return "todos"
        case .todo,
                .updateTodo,
                .deleteTodo:
            return "todos/" // + TodoID
        }
    }
    
    var method: HTTPMethod {
        switch self {
            // GET
        case .allMember,
                .member,
                .allTodos,
                .todo:
            return .get
            
            // POST
        case .signUp,
                .login,
                .createTodo:
            return .post
            
            // PATCH
        case .updateMember,
                .updateTodo:
            return .patch
            
            // DELETE
        case .deleteMember,
                .deleteTodo:
            return .delete
        }
    }
}
