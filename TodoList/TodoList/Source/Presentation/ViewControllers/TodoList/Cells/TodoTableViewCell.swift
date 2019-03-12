//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configUI(todo: Todo){
        lblTitle.text = todo.title
        lblSummary.text = "Testtesttesttestest"
        if let isStrike = todo.complete {
            if isStrike {
                lblTitle.textColor = UIColor.red
                lblTitle.setStrikeThroughStyle(1, UIColor.red)
            }else {
                lblTitle.textColor = UIColor.black
                lblTitle.removeStrikeThroughStyle()
            }
        }
    }
}
