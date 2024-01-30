//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by javier pineda on 25/01/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import RealmSwift

class TaskListViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    var tasks: [TaskItem] = []
    var viewModel: TaskListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel = TaskListViewModelImplemenation(router: TaskListRouterImplementation(controller: self),
                                                   view: self,
                                                   db: Firestore.firestore(),
                                                   auth: Auth.auth(), 
                                                   storageContext: StorageContextImplementation(realm: try? Realm()))
        taskTableView.register(UINib(nibName: TaskTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TaskTableViewCell.identifier)
        viewModel?.getTasks(false)
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }

    @IBAction func signOut(_ sender: UIBarButtonItem) {
        viewModel?.signOut()
    }
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        viewModel?.presentAddTask(task: nil)
    }
}

extension TaskListViewController: TaskListView {
    func showMessageAlert(message: String) {
        showErrorAlert(message: message)
    }
    
    func showFailureAlert(message: String) {
        showErrorAlert(message: message)
    }
    
    func updateContent(tasks: [TaskItem]) {
        self.tasks = tasks
        taskTableView.reloadData()
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        cell.setup(task: tasks[indexPath.row])
        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = tasks[indexPath.row]
        viewModel?.updateTaskStatus(task: task, isCompleted: !task.isCompleted)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return getDeleteActionConfiguration {
            self.viewModel?.presentDeleteConfirmation(task: self.tasks[indexPath.row])
        }
    }
}
