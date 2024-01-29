//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by javier pineda on 25/01/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = "TaskTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(task: TaskItem) {
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        statusButton.setBackgroundImage(task.isCompleted ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle"), for: .normal)
    }

}
