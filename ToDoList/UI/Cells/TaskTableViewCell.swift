//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by javier pineda on 25/01/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    static let identifier = "TaskTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(user: LocalUser) {
        nameLabel.text = user.name
        lastNameLabel.text = user.lastName
        profileImage.image = user.image
    }

}
