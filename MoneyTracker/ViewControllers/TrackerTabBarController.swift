//
//  TrackerTabBarController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 20.06.2022.
//

import UIKit

class TrackerTabBarController: UITabBarController {
    var balance = 0
    
    var categories: [Category] = []
    var operations: [Operation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.createTempData()
        fetchData()
        dataTrasfer()
    }
    
    private func dataTrasfer() {
        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            if let navigationVC = viewController as? UINavigationController {
                if let operationVC = navigationVC.topViewController as? OperationViewController {
                    operationVC.categories = categories
                } else if let historyVC = navigationVC.topViewController as? HistoryTableViewController {
                    historyVC.operations = operations
                }
            }
        }
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
