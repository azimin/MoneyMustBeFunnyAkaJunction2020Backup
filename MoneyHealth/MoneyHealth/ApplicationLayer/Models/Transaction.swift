//
//  Transaction.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation

struct Transaction: Decodable {
    let id: Int

    let amount: Double

    let balance: Double

    let date: TimeInterval

    let currency: String
    let category: Category
}

