//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by javier pineda on 25/01/24.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    var users: [LocalUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        users.append(LocalUser(name: "Reynaldo", lastName: "Mejia", image: nil))
        users.append(LocalUser(name: "Alberto", lastName: "Rojas", image: nil))
        users.append(LocalUser(name: "Victor", lastName: "Arciniega", image: UIImage(systemName: "plus")))
        users.append(LocalUser(name: "Javier pienda gonzalez de mexico y ios...............Javier pienda gonzalez de mexico y ios...............", lastName: "Javier pienda gonzalez de mexico y ios...............Javier pienda gonzalez de mexico y ios...............", image: UIImage(systemName: "plus")))
        taskTableView.register(UINib(nibName: TaskTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TaskTableViewCell.identifier)
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }

    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        cell.setup(user: users[indexPath.row])
        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        print(user)
    }
}
