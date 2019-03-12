//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit

protocol TodoListView : class {
    func startLoading()
    func finishLoading()
    func setTodoList(array : [Todo])
    func setError(err:BaseError?)
    func setSuccessAddTodo()
    func setSuccesDelete()
    func setSuccesReplace()
    func setNoteList(array : [Note])
}

class TodoListPresenter {
    weak private var todoListView: TodoListView?
    private let todoService: TodoServices?
    

    init() {
        self.todoService = TodoServices()
    }
    
    func attachView(view: TodoListView?) {
        guard let view = view else { return }
        todoListView = view
    }
    
    func fetchTodoList(userId : Int){
        var param = [String:Any]()
        param["userId"] = userId
        todoListView?.startLoading()
        todoService?.getTodoList(param, completion: { [weak self] (arrayTodo, error) in
            var arrayTodoTemp = [Todo]()
            arrayTodo?.forEach({ (todo) in
                arrayTodoTemp.append(Todo(title: todo.title, complete: todo.complete, id: todo.id, accountId: todo.accountId))
            })
            self?.todoListView?.setTodoList(array: arrayTodoTemp)
            self?.todoListView?.finishLoading()
        })
    }
    
    func fetchNoteList(by todoId : Int){
        var param = [String:Any]()
        param["todoId"] = todoId
        todoListView?.startLoading()
        todoService?.getNoteList(param, completion: { [weak self] (arrayNote, error) in
            var arrayNoteTemp = [Note]()
            arrayNote?.forEach({ (note) in
                arrayNoteTemp.append(Note(text: note.text, id: note.id, idTodo: note.todoId!))
            })
            self?.todoListView?.setNoteList(array: arrayNoteTemp)
            self?.todoListView?.finishLoading()
        })
    }

    
    func createTodo(by userId: Int, title: String){
        var param = [String:Any]()
        param["userId"] = userId
        param["title"] = title
        todoListView?.startLoading()
        todoService?.createTodo(param, completion: { [weak self] (response, error) in
            self?.todoListView?.finishLoading()
            if error != nil {
                // popUp err
                let errTemp = BaseError(code: 200, message: "Error")
                self?.todoListView?.setError(err: errTemp)
            }else {
                self?.todoListView?.setSuccessAddTodo()
            }
        })
    }
    
    func deleteTodo(by todoId: Int){
        var param = [String:Any]()
        param["todoId"] = todoId
        todoListView?.startLoading()
        todoService?.deleteTodo(param, completion: { [weak self] (response, error) in
            self?.todoListView?.finishLoading()
            if error != nil {
                // popUp err
                let errTemp = BaseError(code: 200, message: "Error")
                self?.todoListView?.setError(err: errTemp)
            }else {
                self?.todoListView?.setSuccesDelete()
            }
        })
    }
    
    func replaceTodo(by todoId: Int , complete: Bool? , title: String? ){
        var param = [String:Any]()
        param["todoId"] = todoId
        if let complete = complete {
            param["complete"] = complete
        }
        if let title = title {
            param["title"] = title
        }
        todoListView?.startLoading()
        todoService?.replaceTodo(param, completion: { [weak self] (response, error) in
            self?.todoListView?.finishLoading()
            if error != nil {
                // popUp err
                let errTemp = BaseError(code: 200, message: "Error")
                self?.todoListView?.setError(err: errTemp)
            }else {
                self?.todoListView?.setSuccesDelete()
            }
        })
    }
    
}
