//
//  MonthSpendAmount.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation

class MonthAmount {

    let month: Month

    let amount: Double

    var nextMonthAmount: MonthAmount?

    let categories: [Category: Double]
    
    init(
        month: Month,
        amount: Double,
        categories: [Category: Double]
    ) {
        self.month = month
        self.amount = amount
        self.categories = categories
    }
}
