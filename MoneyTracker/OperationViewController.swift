//
//  OperationViewController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 15.06.2022.
//

import UIKit

class OperationViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var operationTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    private let reuseIdentifier = "categoryCell"
    private let categories: [Category] = Category.getCategories()
    private var operations: [Operation] = []
    private var currentCategories: [Category] = []
    private var selectedCategory: Category!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchOperationTypes()
    }

    @IBAction func selectOperationSegment() {
        switchOperationTypes()
    }
    
    @IBAction func AddButtonPressed() {
        guard let sum = sumLabel.text else { return }
        guard let sumInt = Int(sum) else { return }
        
        let operation = Operation(sum: sumInt, category: selectedCategory)
        operations.insert(operation, at: 0)
        
        categoryLabel.text = "Категория"
        sumLabel.text = "Сумма"
        showSuccessAlert(for: sumInt, and: selectedCategory.title)
    }
    
    
    private func switchOperationTypes() {
        switch operationTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            currentCategories = categories.filter { category in
                category.type == .income
            }
        default:
            currentCategories = categories.filter { category in
                category.type == .expense
            }
        }
        categoryCollectionView.reloadData()
    }
}

extension OperationViewController: UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryImage.image = UIImage(named: currentCategories[indexPath.row].image)
        cell.categoryImage.backgroundColor = UIColor(named: currentCategories[indexPath.row].color)
        cell.categotyTitle.text = currentCategories[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAlert(for: currentCategories[indexPath.row])
    }
    
    private func showAlert(for category: Category) {
        
        let alert = UIAlertController(title: "Введите сумму", message: "для категории '\(category.title)'", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Cумма ₽..."
        }
        
        let doneAction = UIAlertAction(title: "Добавить", style: .default) { action in
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
    
    private func showSuccessAlert(for sum: Int, and category: String) {
        let alert = UIAlertController(title: "Операция успешно добавлена", message: "\(category) на сумму \(sum) ₽", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

