//
//  File.swift
//  TaskList(Composite)
//
//  Created by Денис Ледовский on 02.04.2022.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifire: String {get}
}

final class TaskCell: UITableViewCell {

    let taskLabel = UILabel()
    let taskCounterLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TaskCell.identifire)
        self.addSubview(taskLabel)
        self.addSubview(taskCounterLabel)
        setupLayouts()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(taskName: String, subTasksCounter: Int) {
        taskLabel.text = taskName
        taskCounterLabel.text = subTasksCounter.description
    }

    private func setupLayouts() {
        taskLabel.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
           ])

        taskCounterLabel.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
            taskCounterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskCounterLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 300)
           ])
    }
}

extension TaskCell: ReusableView {
    static var identifire: String {
        return String(describing: self)
    }
}
