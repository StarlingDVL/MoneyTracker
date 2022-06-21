//
//  HistoryTableViewController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 20.06.2022.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var operations: [Operation]!
    var delegate: TrackerTabBarControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        StorageManager.shared.fetchData()
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
        content.secondaryText = category.isExpense ? "\(myCell.sum)" : "+\(myCell.sum)"
        content.secondaryTextProperties.color = category.isExpense ? .gray : .systemBlue
        content.secondaryTextProperties.font = category.isExpense ? .systemFont(ofSize: 17) : .boldSystemFont(ofSize: 18)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor(named: "Background")

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
