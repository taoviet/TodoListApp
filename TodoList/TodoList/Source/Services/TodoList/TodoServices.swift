//
//  TodoService.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class TodoServices {
    
    func getTodoList(_ param: [String:Any], completion: @escaping ([TodoResponse]?, BaseError?) -> Void) -> Void {
        AF.request(ApiRouter.todoList(param)).responseArray { (response: DataResponse<[TodoResponse]>) in
            if response.result.value != nil {
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:nil) )
            }else {
                let baseResponseErrAuth = BaseResponse()
                baseResponseErrAuth.messageError = "Auth"
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:baseResponseErrAuth) )
            }
        }
    }
    
    func createTodo(_ param: [String:Any], completion: @escaping (TodoResponse?, BaseError?) -> Void) -> Void {
        AF.request(ApiRouter.createTodo(param)).responseObject { (response: DataResponse<TodoResponse>) in
            if response.result.value != nil {
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:nil) )
            }else {
                let baseResponseErrAuth = BaseResponse()
                baseResponseErrAuth.messageError = "Auth"
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:baseResponseErrAuth) )
            }
        }
    }
    
    func deleteTodo(_ param: [String:Any], completion: @escaping (TodoResponse?, BaseError?) -> Void) -> Void {
        AF.request(ApiRouter.deleteTodo(param)).responseObject { (response: DataResponse<TodoResponse>) in
            if response.result.value != nil {
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:nil) )
            }else {
                let baseResponseErrAuth = BaseResponse()
                baseResponseErrAuth.messageError = "Auth"
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:baseResponseErrAuth) )
            }
        }
    }
    
    func replaceTodo(_ param: [String:Any], completion: @escaping (TodoResponse?, BaseError?) -> Void) -> Void {
        AF.request(ApiRouter.replaceTodo(param)).responseObject { (response: DataResponse<TodoResponse>) in
            if response.result.value != nil {
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:nil) )
            }else {
                let baseResponseErrAuth = BaseResponse()
                baseResponseErrAuth.messageError = "Auth"
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:baseResponseErrAuth) )
            }
        }
    }

    func getNoteList(_ param: [String:Any], completion: @escaping ([NoteResponse]?, BaseError?) -> Void) -> Void {
        AF.request(ApiRouter.noteList(param)).responseArray { (response: DataResponse<[NoteResponse]>) in
            if response.result.value != nil {
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:nil) )
            }else {
                let baseResponseErrAuth = BaseResponse()
                baseResponseErrAuth.messageError = "Auth"
                completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response:baseResponseErrAuth) )
            }
        }
    }
}

