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
}
