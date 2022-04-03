//
//  ProtocolCpmposite.swift
//  TaskList(Composite)
//
//  Created by Денис Ледовский on 02.04.2022.
//

import Foundation

protocol TaskComposite {

    var mainTask: TaskComposite? { get }
    var subTask: [Task] { get set }
    var name: String { get set }

    func add(task: Task)
}
