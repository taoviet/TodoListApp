//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {
    @IBOutlet weak var txtInputTitle: UITextField!
    var sendFormAddTodo : ((_ textTitle: String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func actionCancel(_ sender: Any) {
        appDelegate?.dismiss()
    }
    
    @IBAction func actionSaveTodo(_ sender: Any) {
        if !(txtInputTitle.text?.isEmptyOrWhitespace())! {
            self.sendFormAddTodo!(txtInputTitle.text!)
            appDelegate?.dismiss()
        }
    }

}
