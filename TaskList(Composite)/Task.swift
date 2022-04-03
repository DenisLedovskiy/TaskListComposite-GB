//
//  Task.swift
//  TaskList(Composite)
//
//  Created by Денис Ледовский on 02.04.2022.
//

import Foundation

class Task: TaskComposite {

    var mainTask: TaskComposite?
    var subTask: [Task] = []
    var name: String

    init(name: String, parent: TaskComposite?) {
        self.name = name
        self.mainTask = parent
    }

    func add(task: Task) {
        subTask.append(task)
    }
}
