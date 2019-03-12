//
//  NoteViewController.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var arrayNote: [Note]!
    var isDone: Bool!
    var callAPIPressDone : ((_ idTodo: Int) -> Void)?
    var todoTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setUpUI()
        navigationItem.title = todoTitle
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if arrayNote.count != 0 && isDone {
            callAPIPressDone!((arrayNote.first?.idTodo)!)
        }
    }
    
    
    private func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCellNib(NoteTableViewCell.self)
    }
    private func setUpUI(){
        if isDone {
            btnDone.setTitle("Tick", for: .normal)
        }else {
            btnDone.setTitle("NotTick", for: .normal)
        }
    }
    
    @IBAction func actionDone(_ sender: Any) {
        isDone = !isDone
        setUpUI()
    }
    
}

extension NoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrayNote.count)
        return arrayNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String.className(NoteTableViewCell.self), for: indexPath) as? NoteTableViewCell{
            cell.lblText.text = arrayNote[indexPath.row].text
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayNote.count == 0 {
            return 0
        }
        return 69
    }
    
}

extension NoteViewController: UITableViewDelegate {
    
}
