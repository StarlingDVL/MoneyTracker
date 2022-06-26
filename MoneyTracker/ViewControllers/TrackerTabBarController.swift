//
//  TrackerTabBarController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 20.06.2022.
//

import UIKit

protocol TrackerTabBarControllerDelegate {
    func dataTransfer()
}

class TrackerTabBarController: UITabBarController {
    var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.createTempData()
        fetchCategoriesData()
        dataTransfer()
    }
    
    private func fetchCategoriesData() {
        StorageManager.shared.fetchCategoriesData { result in
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - extension for TrackerTabBaerControllerDelegate

extension TrackerTabBarController: TrackerTabBarControllerDelegate {
    func dataTransfer() {
        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            if let navigationVC = viewController as? UINavigationController {
                if let historyVC = navigationVC.topViewController as? HistoryTableViewController {
                    historyVC.tableView.reloadData()
                }
            } else if let operationVC = viewController as? OperationViewController {
                operationVC.categories = categories
                operationVC.delegate = self
            }
        }
    }
}
