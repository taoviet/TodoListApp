//
//  ApiRouter.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
import Alamofire

enum ContentType: String {
    case json = "application/json"
    case xml  = "application/x-www-form-urlencoded"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ApiRouter: URLRequestConvertible {
    case login([String: Any])
    case todoList([String:Any])
    case createTodo([String:Any])
    case deleteTodo([String:Any])
    case replaceTodo([String:Any])
    case noteList([String:Any])
    
    
    // Http method
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .todoList:
            return .get
        case .createTodo:
            return .post
        case .deleteTodo:
            return .delete
        case .replaceTodo:
            return .patch
        case .noteList:
            return .get
        }
    }
    
    // path
    private var path: String {
        switch self {
        case .login:
            return API_LINK_LOGIN
        case .todoList(let paramater):
            return API_ACCOUNT + "\(paramater["userId"] ?? "")" + "/todos"
        case .createTodo(let paramater):
            return API_ACCOUNT +  "\(paramater["userId"] ?? "")" + "/todos"
        case .deleteTodo(let paramater):
            return API_TODO +  "\(paramater["todoId"] ?? "")"
        case .replaceTodo(let paramater):
            return API_TODO +  "\(paramater["todoId"] ?? "")"
        case .noteList(let paramater):
            return API_TODO +  "\(paramater["todoId"] ?? "")" + "/notes"
        }
    
    }
    

    private var parameters: Parameters? {
        switch self {
        case .login(let paramater):
            return paramater
        case .todoList( _):
            return nil
        case .createTodo(let paramter):
            var paramTemp = [String:Any]()
            paramTemp["title"] = paramter["title"]
            return paramTemp
        case .deleteTodo( _):
            return nil
        case .replaceTodo(let paramter):
            var paramTemp = [String:Any]()
            if let completion = paramter["complete"] {
                paramTemp["complete"] = completion
            }
            
            if let title = paramter["title"] {
                paramTemp["title"] = title
            }
            return paramTemp
        case .noteList( _):
            return nil
        }
    }
    

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Bundle.infoPlist.baseURL)
        var urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        if let user = UIUtils.getObjectFromUserDefault(UserDefaultKey.keyUserlogined) as? UserLogined {
            urlRequest.setValue(user.id, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.xml.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
    }
}

