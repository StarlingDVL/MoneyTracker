//
//  HistoryTableViewController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 20.06.2022.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var balance: Int!
    var operations: [Operation]!
    var delegate: TrackerTabBarControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        operations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let myCell = operations[indexPath.row]
        
        let image = UIImage(data: (myCell.category?.image) ?? Data())
        guard let category = myCell.category else { return UITableViewCell() }
        
        var content = cell.defaultContentConfiguration()
        
        content.text = myCell.category?.title
        content.image = image
        content.secondaryText = category.isExpense ? "\(myCell.sum)₽" : "+\(myCell.sum)₽"
        content.secondaryTextProperties.color = category.isExpense ? .gray : .systemBlue
        content.secondaryTextProperties.font = category.isExpense ? .systemFont(ofSize: 17) : .boldSystemFont(ofSize: 18)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor(named: "Background")

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let operation = operations[indexPath.row]
        
        if editingStyle == .delete {
            StorageManager.shared.deleteOperation(operation)
            operations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            delegate.getOperationList(with: operations)
            delegate.getBalance(with: balance)
            delegate.dataTransfer()
        }
    }
}
