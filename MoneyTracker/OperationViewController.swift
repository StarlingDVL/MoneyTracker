//
//  OperationViewController.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 15.06.2022.
//

import UIKit

class OperationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let reuseIdentifier = "categoryCell"
    private let categories: [Category] = Category.getCategories()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.categoryImage.image = UIImage(named: categories[indexPath.row].image)
        cell.categoryImage.backgroundColor = UIColor(named: categories[indexPath.row].color)
        cell.categotyTitle.text = categories[indexPath.row].title
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

