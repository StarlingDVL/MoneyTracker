//
//  DataManager.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 20.06.2022.
//

import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData() {
        if !UserDefaults.standard.bool(forKey: "Done") {
            StorageManager.shared.saveCategory(
                title: "Перевод",
                image: convertImageToData(image: UIImage(named: "Перевод") ?? UIImage()),
                isExpense: true,
                color: convertColorToDic(color: UIColor(named: "Arrows") ?? .systemOrange)
            )
            StorageManager.shared.saveCategory(
                title: "Перевод",
                image: convertImageToData(image: UIImage(named: "Перевод") ?? UIImage()),
                isExpense: false,
                color: convertColorToDic(color: UIColor(named: "ArrowsInc") ?? .systemGreen)
            )
            StorageManager.shared.saveCategory(
                title: "Кредит",
                image: convertImageToData(image: UIImage(named: "Кредит") ?? UIImage()),
                isExpense: true,
                color: convertColorToDic(color: UIColor(named: "Bank") ?? .systemOrange)
            )
            StorageManager.shared.saveCategory(
                title: "Вклад",
                image: convertImageToData(image: UIImage(named: "Кредит") ?? UIImage()),
                isExpense: false,
                color: convertColorToDic(color: UIColor(named: "BankInc") ?? .systemGreen)
            )
            
            UserDefaults.standard.set(true, forKey: "Done")
        }
    }
    
    
    private func convertImageToData(image: UIImage) -> Data {
        guard let imageData = image.pngData() else { return Data() }
        return imageData
    }
    
    private func convertDataToImage(imageData: Data) -> UIImage {
        guard let image = UIImage(data: imageData) else { return UIImage() }
        return image
    }
    
    private func getColor(colorDictionary: [String : Float]) -> UIColor {
        guard let red  = colorDictionary["red"],
              let green = colorDictionary["green"],
              let blue = colorDictionary["blue"] else { return UIColor() }
        
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1)
    }
    
    private func convertColorToDic(color: UIColor) -> [String : Float] {
        let ciColor = CIColor(color: color)
        var colorDictionary = [String : Float]()
        
        colorDictionary["red"] = Float(ciColor.red)
        colorDictionary["green"] = Float(ciColor.green)
        colorDictionary["blue"] = Float(ciColor.blue)
        
        return colorDictionary
    }
    
}
extension UIColor {
    convenience init(dictionary: [String : Float]) {
        self.init(red: CGFloat((dictionary["red"] ?? 1) / 255), green: CGFloat((dictionary["green"] ?? 1) / 255), blue: CGFloat((dictionary["blue"] ?? 1) / 255), alpha: 1)
    }
}

