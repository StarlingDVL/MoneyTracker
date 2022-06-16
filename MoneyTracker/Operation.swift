//
//  Operation.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 15.06.2022.
//

import Foundation

enum OperationType: String {
    case income = "Доход"
    case expense = "Расход"
}

struct Operation {
    let sum: Int
    let date = Date()
    let category: Category
}

struct Category {
    let title: String
    let image: String
    let color: String
    let type: OperationType
    
    static func getCategories() -> [Category] {
        [
            Category(title: "Перевод", image: "Перевод", color: "ArrowsInc", type: .income),
            Category(title: "Перевод", image: "Перевод", color: "Arrows", type: .expense),
            Category(title: "Кредит", image: "Кредит", color: "Bank", type: .expense),
            Category(title: "Вклад", image: "Кредит", color: "BankInc", type: .income),
            Category(title: "Подарок", image: "Подарок", color: "Gift", type: .income),
            Category(title: "Автомобиль", image: "Автомобиль", color: "Auto", type: .expense),
            Category(title: "Алкоголь", image: "Алкоголь", color: "Alco", type: .expense),
            Category(title: "Спорт", image: "Гантеля", color: "Gym", type: .expense),
            Category(title: "ЖКХ", image: "ЖКХ", color: "Home", type: .expense),
            Category(title: "Зарплата", image: "Зарплата", color: "Salary", type: .income),
            Category(title: "Интернет", image: "Интернет", color: "Wi-Fi", type: .expense),
            Category(title: "Кино/Театр", image: "Кино", color: "Cinema", type: .expense),
            Category(title: "Кофе", image: "Кофе", color: "Coffee", type: .expense),
            Category(title: "Здоровье", image: "Крест", color: "Plus", type: .expense),
            Category(title: "Техника", image: "Машинка", color: "Wash", type: .expense),
            Category(title: "Спорттовары", image: "Мяч", color: "Ball", type: .expense),
            Category(title: "Одежда", image: "Одежда", color: "Cloathers", type: .expense),
            Category(title: "Путешествие", image: "Пальма", color: "Tree", type: .expense),
            Category(title: "Поезд", image: "Поезд", color: "Train", type: .expense),
            Category(title: "Праздник", image: "Праздник", color: "Holiday", type: .expense),
            Category(title: "Продукты", image: "Продукты", color: "Store", type: .expense),
            Category(title: "Ресторан", image: "Ресторан", color: "Restaurant", type: .expense),
            Category(title: "Самолет", image: "Самолет", color: "Plain", type: .expense),
            Category(title: "Питомец", image: "Собака", color: "Dog", type: .expense),
            Category(title: "Другое", image: "Стрелки", color: "CrossArrows", type: .expense),
            Category(title: "Другое", image: "Стрелки", color: "CrossArrows", type: .income),
            Category(title: "Такси", image: "Такси", color: "Taxi", type: .expense),
            Category(title: "Телефон", image: "Телефон", color: "Iphone", type: .expense),
            Category(title: "Транспорт", image: "Транспорт", color: "Transport", type: .expense),
            Category(title: "Товары для дома", image: "Утюг", color: "Iron", type: .expense)
        ]
    }
}
