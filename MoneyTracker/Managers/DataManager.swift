//
//  DataManager.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 20.06.2022.
//

import UIKit

final class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData() {
        if !UserDefaults.standard.bool(forKey: "Done") {
            StorageManager.shared.saveCategory(
                title: "Перевод",
                image: convertImageToData(image: UIImage(named: "ПереводР") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Продукты",
                image: convertImageToData(image: UIImage(named: "Продукты") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Кофе",
                image: convertImageToData(image: UIImage(named: "Кофе") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Автомобиль",
                image: convertImageToData(image: UIImage(named: "Автомобиль") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Транспорт",
                image: convertImageToData(image: UIImage(named: "Транспорт") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Такси",
                image: convertImageToData(image: UIImage(named: "Такси") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Кино/Театр",
                image: convertImageToData(image: UIImage(named: "Кино") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Ресторан",
                image: convertImageToData(image: UIImage(named: "Ресторан") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Бар/Алкоголь",
                image: convertImageToData(image: UIImage(named: "Алкоголь") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Кредит",
                image: convertImageToData(image: UIImage(named: "Кредит") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Питомец",
                image: convertImageToData(image: UIImage(named: "Собака") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Спорт",
                image: convertImageToData(image: UIImage(named: "Гантеля") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Спорттовары",
                image: convertImageToData(image: UIImage(named: "Мяч") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Одежда",
                image: convertImageToData(image: UIImage(named: "Одежда") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Товары для дома",
                image: convertImageToData(image: UIImage(named: "Утюг") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Телефон",
                image: convertImageToData(image: UIImage(named: "Телефон") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Интернет",
                image: convertImageToData(image: UIImage(named: "Интернет") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "ЖКХ",
                image: convertImageToData(image: UIImage(named: "ЖКХ") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Праздник",
                image: convertImageToData(image: UIImage(named: "Праздник") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Самолет",
                image: convertImageToData(image: UIImage(named: "Самолет") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Здоровье",
                image: convertImageToData(image: UIImage(named: "Крест") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Поезд",
                image: convertImageToData(image: UIImage(named: "Поезд") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Путешествие",
                image: convertImageToData(image: UIImage(named: "Пальма") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Техника",
                image: convertImageToData(image: UIImage(named: "Машинка") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Другое",
                image: convertImageToData(image: UIImage(named: "Другое") ?? UIImage()),
                isExpense: true
            )
            StorageManager.shared.saveCategory(
                title: "Зарплата",
                image: convertImageToData(image: UIImage(named: "Зарплата") ?? UIImage()),
                isExpense: false
            )
            StorageManager.shared.saveCategory(
                title: "Перевод",
                image: convertImageToData(image: UIImage(named: "Перевод") ?? UIImage()),
                isExpense: false
            )
            StorageManager.shared.saveCategory(
                title: "Подарок",
                image: convertImageToData(image: UIImage(named: "Подарок") ?? UIImage()),
                isExpense: false
            )
            StorageManager.shared.saveCategory(
                title: "Вклад",
                image: convertImageToData(image: UIImage(named: "Вклад") ?? UIImage()),
                isExpense: false
            )
            StorageManager.shared.saveCategory(
                title: "Другое",
                image: convertImageToData(image: UIImage(named: "Другое") ?? UIImage()),
                isExpense: false
            )
            
            UserDefaults.standard.set(true, forKey: "Done")
        }
    }
    
    func convertDataToImage(imageData: Data) -> UIImage {
        guard let image = UIImage(data: imageData) else { return UIImage() }
        return image
    }
    
    private func convertImageToData(image: UIImage) -> Data {
        guard let imageData = image.pngData() else { return Data() }
        return imageData
    }
}
