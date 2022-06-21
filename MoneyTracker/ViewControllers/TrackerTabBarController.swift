//
//  TrackerTabBarController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 20.06.2022.
//

import UIKit

protocol TrackerTabBarControllerDelegate {
    func getOperationList(with operation: Operation)
    func getBalance(with balance: Int)
    func dataTransfer()
}

class TrackerTabBarController: UITabBarController {
    var balance = 0
    
    var categories: [Category] = []
    var operations: [Operation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.createTempData()
        fetchData()
        dataTransfer()
    }
    
    private func fetchData() {
        StorageManager.shared.fetchCategoriesData { result in
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        StorageManager.shared.fetchOperationData { result in
            switch result {
            case .success(let operations):
                self.operations = operations
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        StorageManager.shared.fetchBalance { result in
            switch result {
            case .success(let amount):
                for sum in amount {
                    self.balance += Int(sum.amount)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - extension for TrackerTabBaerControllerDelegate

extension TrackerTabBarController: TrackerTabBarControllerDelegate {
    func getBalance(with balance: Int) {
        self.balance = balance
    }
    
    func getOperationList(with operation: Operation) {
        operations.append(operation)
    }
    
    func dataTransfer() {
        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            if let navigationVC = viewController as? UINavigationController {
                if let historyVC = navigationVC.topViewController as? HistoryTableViewController {
                    historyVC.operations = operations
                    historyVC.delegate = self
                    historyVC.tableView.reloadData()
                }
            } else if let operationVC = viewController as? OperationViewController {
                operationVC.categories = categories
                operationVC.balance = balance
                operationVC.delegate = self
            }
        }
    }
}
