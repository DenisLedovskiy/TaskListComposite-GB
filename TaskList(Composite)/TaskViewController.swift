//
//  TaskViewController.swift
//  TaskList(Composite)
//
//  Created by Денис Ледовский on 02.04.2022.
//

import UIKit


class TaskViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!

    var task = Task(name: "", parent: nil)
    private let segueIdentifire = "reuseTaskController"

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.taskTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskTableView.dataSource = self
        self.taskTableView.delegate = self
        self.taskTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifire)
        navigationItem.title = task.name
        self.taskTableView.reloadData()
    }
    
    @IBAction func addTask(_ sender: Any) {
        TextAlert().textAlert() { [weak self] userInput in
            guard let self = self else {return}
            guard userInput != "" else { return }
            self.task.add(task: Task(name: userInput, parent: self.task))
            self.taskTableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifire,
           let destinationVC = segue.destination as? TaskViewController,
           let task = sender as? Task {
            destinationVC.task = task.self
        }
    }
}


extension TaskViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.subTask.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifire,
                                                       for: indexPath) as? TaskCell else {return UITableViewCell()}

        let taskName = task.subTask[indexPath.row].name.description
        let subTasksCounter = task.subTask[indexPath.row].subTask.count
        cell.accessoryType = .disclosureIndicator
        cell.configure(taskName: taskName, subTasksCounter: subTasksCounter)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifire, sender: task.subTask[indexPath.row])
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            task.subTask.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}





