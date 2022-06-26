//
//  HistoryTableViewController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 20.06.2022.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = StorageManager.shared.fetchResulController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let operation = StorageManager.shared.fetchResulController.object(at: indexPath)
        let image = UIImage(data: (operation.category?.image) ?? Data())
        
        guard let category = operation.category else { return UITableViewCell() }
        
        var content = cell.defaultContentConfiguration()
        
        content.text = category.title
        content.image = image
        content.secondaryText = category.isExpense ? "\(operation.sum)₽" : "+\(operation.sum)₽"
        content.secondaryTextProperties.color = category.isExpense ? .gray : .systemBlue
        content.secondaryTextProperties.font = category.isExpense ? .systemFont(ofSize: 17) : .boldSystemFont(ofSize: 18)
        
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor(named: "Background")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let operation = StorageManager.shared.fetchResulController.object(at: indexPath)
        
        if editingStyle == .delete {
            StorageManager.shared.deleteOperation(operation)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    }
}
