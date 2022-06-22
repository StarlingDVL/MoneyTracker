//
//  OperationViewController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 15.06.2022.
//

import UIKit

class OperationViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var operationTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    // MARK: - Public Properties
    
    var operations: [Operation] = []
    var categories: [Category]!
    var balance = 0
    var delegate: TrackerTabBarControllerDelegate!
    
    // MARK: - Private Properties
    
    private let reuseIdentifier = "categoryCell"
    
    private var currentCategories: [Category] = []
    private var selectedCategory: Category?
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        balanceLabel.text = "\(balance) ₽"
        switchOperationTypes()
    }
    
    // MARK: - IBActions
    
    @IBAction func selectOperationSegment() {
        switchOperationTypes()
    }
    
    @IBAction func AddButtonPressed() {
        guard let sum = sumLabel.text else { return }
        guard let sumInt = Int(sum) else { return }
        guard let selectedCategory = selectedCategory else {
            return
        }
        
        categoryLabel.text = "Категория"
        sumLabel.text = "Сумма"
        
        StorageManager.shared.saveBalance(sum: !selectedCategory.isExpense ? sumInt : sumInt * -1)
        StorageManager.shared.saveOperation(sum: sumInt, category: selectedCategory) { operation in
            showSuccessAlert(for: operation)
            calculateBalance(for: operation)
            operations.append(operation)
            delegate.getOperation(with: operation)
        }
        
        delegate.getBalance(with: balance)
        delegate.dataTransfer()
        balanceLabel.text = "\(balance) ₽"
    }
    
    // MARK: - Private Methods
    
    private func switchOperationTypes() {
        switch operationTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            currentCategories = categories.filter { category in
                !category.isExpense
            }
        default:
            currentCategories = categories.filter { category in
                category.isExpense
            }
        }
        categoryCollectionView.reloadData()
    }
    
    private func calculateBalance(for operation: Operation) {
            guard let categoryIsExpense = operation.category?.isExpense else { return }
            
            if categoryIsExpense {
                balance -= Int(operation.sum)
            } else {
                balance += Int(operation.sum)
            }
    }
}
    
// MARK: - Extension for CollectionViewDataSource, CollectionViewDelegate and AlertControllers

extension OperationViewController: UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.contentView.backgroundColor = UIColor(named: "ContentView")
        cell.categoryImage.image = UIImage(data: currentCategories[indexPath.row].image ?? Data())
        cell.categotyTitle.text = currentCategories[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAlert(for: currentCategories[indexPath.row])
    }
    
    private func showAlert(for category: Category) {
        
        let alert = UIAlertController(
            title: "Введите сумму",
            message: "для категории '\(category.title ?? "Неизвестно")'",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "Cумма ₽..."
        }
        
        let doneAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            let textField = alert.textFields?.first
            guard let sum = textField?.text else { return }
            
            self.selectedCategory = category
            self.categoryLabel.text = category.title
            self.sumLabel.text = "\(sum)"
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        
        present(alert, animated: true)
    }
    
    private func showSuccessAlert(for operation: Operation) {
        let alert = UIAlertController(
            title: "Операция успешно добавлена",
            message: "\(operation.category?.title ?? "") на сумму \(operation.sum) ₽",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
