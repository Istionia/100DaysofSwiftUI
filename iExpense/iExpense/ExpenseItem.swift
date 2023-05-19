//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Timothy on 06/10/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
