//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    private var todoListPresenter: TodoListPresenter!
    private var arrayTodo: [Todo] = [Todo]()
    private var userId: Int!
    private var todoIsSelected:Todo!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        todoListPresenter = TodoListPresenter()
        todoListPresenter.attachView(view: self)
        getUserId()
        todoListPresenter.fetchTodoList(userId: userId)
        configTableView()
        addPlusButtonNaviBar()
        navigationItem.title = "TODO LIST"
    }
    
    private func getUserId(){
        if let user = UIUtils.getObjectFromUserDefault(UserDefaultKey.keyUserlogined) as? UserLogined {
            userId = user.userId
        }
    }
    
    private func configTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerCellNib(TodoTableViewCell.self)
    }
    
    private func addPlusButtonNaviBar(){
        let rightBarButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(handleRightBarButton))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func handleRightBarButton(){
        // add notes
        let vcAddTodo = UIUtils.viewControllerWithIndentifier(identifier: "addtodo", storyboardName: "Main") as! AddTodoViewController
        vcAddTodo.sendFormAddTodo = { title in
            self.callAPIAddTodo(title)
        }
        vcAddTodo.modalTransitionStyle = .crossDissolve
        vcAddTodo.modalPresentationStyle = .overCurrentContext
        appDelegate?.presentViewControllerWithoutAnimate(vcAddTodo)
    }
    
    private func callAPIAddTodo(_ textTitle: String){
        todoListPresenter.createTodo(by: userId , title: textTitle)
    }
    
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTodo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String.className(TodoTableViewCell.self), for: indexPath) as? TodoTableViewCell{
            cell.configUI(todo: arrayTodo[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            // edit todo
            self.todoIsSelected = self.arrayTodo[indexPath.row]
            self.gotoNoteVC(idTodo: self.todoIsSelected.id!)
        }
        edit.backgroundColor = UIColor.lightGray
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            // delete todo
            self.showDeleteTodoAlert(idTodo: self.arrayTodo[indexPath.row].id!)
        }
        delete.backgroundColor = UIColor.red
        
        
        return [delete, edit]
    }
        
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    
    private func gotoNoteVC(idTodo: Int){
        todoListPresenter.fetchNoteList(by: idTodo)
    }
    
    private func showDeleteTodoAlert(idTodo: Int){
        let alert = UIAlertController(title: "Comfirmation", message: "Are you sure delete this item", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.todoListPresenter.deleteTodo(by: idTodo)
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.todoIsSelected = self.arrayTodo[indexPath.row]
        self.gotoNoteVC(idTodo: self.todoIsSelected.id!)
    }
    
}

extension TodoListViewController : TodoListView {
    
    func setNoteList(array: [Note]) {
        let noteVc = UIUtils.viewControllerWithIndentifier(identifier: "note", storyboardName: "Main") as! NoteViewController
        noteVc.arrayNote = array
        noteVc.isDone = todoIsSelected.complete
        noteVc.todoTitle = todoIsSelected.title
        noteVc.callAPIPressDone = { idTodo in
            self.todoListPresenter.replaceTodo(by: idTodo, complete: true, title: nil)
        }
        self.navigationController?.pushViewController(noteVc, animated: true)
    }
    
    
    func setSuccesDelete() {
        todoListPresenter.fetchTodoList(userId: userId)
    }
    
    func setSuccesReplace() {
        todoListPresenter.fetchTodoList(userId: userId)
    }
    
    func setSuccessAddTodo() {
        todoListPresenter.fetchTodoList(userId: userId)
    }
    
    func startLoading() {
        self.showLoadingView(true)
    }
    
    func finishLoading() {
        self.showLoadingView(false)
    }
    
    func setTodoList(array: [Todo]) {
        self.arrayTodo = array
        self.tableView.reloadData()
    }
    
    func setError(err: BaseError?) {
        // show pop up
    }
    
    
}
