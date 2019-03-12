//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit

protocol LoginView : class {
    func startLoading()
    func finishLoading()
    func setUser(user : UserLogined?)
    func setError(err:BaseError?)
}

class LoginPresenter {
    weak private var loginView: LoginView?
    private let accountService: AccountServices?
    
    // can use DI
    init() {
        self.accountService = AccountServices()
    }
    
    func attachView(view: LoginView?) {
        guard let view = view else { return }
        loginView = view
    }
    
    func signIn( username : String , password : String) {
        var param = [String:Any]()
        param["username"] = username
        param["password"] = password
        self.loginView?.startLoading()
        accountService?.signIn(param, completion: { (response, error) in
            self.loginView?.finishLoading()
            if error == nil {
                let userResponse = UserLogined(id: response?.id, ttl: response?.ttl, userId: response?.userId)
                self.loginView?.setUser(user: userResponse)
            }else {
                self.loginView?.setError(err: error)
            }
        })
    }
    
}
