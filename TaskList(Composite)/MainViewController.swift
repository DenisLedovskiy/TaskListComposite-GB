//
//  ViewController.swift
//  TaskList(Composite)
//
//  Created by Денис Ледовский on 02.04.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!

    var taskSystem = Task(name: "Список задач", parent: nil)
    private let segueIdentifire = "fromMainToTask"

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.mainTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifire)
        navigationItem.title = taskSystem.name
        self.mainTableView.reloadData()

    }

    @IBAction func addTask(_ sender: Any) {
        TextAlert().textAlert() { [weak self] userInput in
            guard let self = self else {return}
            guard userInput != "" else { return }

            self.taskSystem.add(task: Task(name: userInput, parent: self.taskSystem))

            self.mainTableView.reloadData()
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

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskSystem.subTask.count
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifire, for: indexPath) as? TaskCell else {return UITableViewCell()}

        let taskName = taskSystem.subTask[indexPath.row].name.description
        let subTasksCounter = taskSystem.subTask[indexPath.row].subTask.count
        cell.accessoryType = .disclosureIndicator
        cell.configure(taskName: taskName, subTasksCounter: subTasksCounter)

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifire, sender: taskSystem.subTask[indexPath.row])
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskSystem.subTask.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
