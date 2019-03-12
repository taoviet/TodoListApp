//
//  ViewController.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtUserName: UITextField!

    @IBOutlet weak var lblError: UILabel!
    private var loginPresenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter = LoginPresenter()
        loginPresenter.attachView(view: self)
        lblError.text = ""
        lblError.textColor = UIColor.red
    }

    @IBAction func LoginAction(_ sender: Any) {
        
        if validateAndHandleEmpty() {
            loginPresenter.signIn(username: txtUserName.text!, password: txtPass.text!)
        }else {
            lblError.text = "Wrong password or username"
        }
    }
    
    func validateAndHandleEmpty() -> Bool{
        if (txtUserName.text?.isEmptyOrWhitespace())! && (txtPass.text?.isEmptyOrWhitespace())! {
            return false
        }else {
            return true
        }
    }
    
}


extension LoginViewController: LoginView {
    func startLoading() {
        self.showLoadingView(true)
    }
    
    func finishLoading() {
        self.showLoadingView(false)
    }
    
    func setUser(user: UserLogined?) {
        UIUtils.storeObjectToUserDefault(user!, key: UserDefaultKey.keyUserlogined)
        // change root view
         let vcTodoList = UIUtils.viewControllerWithIndentifier(identifier: "todoList", storyboardName: "Main")
        let navigationCotroller = UINavigationController(rootViewController: vcTodoList)
        self.appDelegate?.changeRootViewController(navigationCotroller)
    }
    
    func setError(err: BaseError?) {
        lblError.text = "Wrong password or username"
    }
    
    
}

