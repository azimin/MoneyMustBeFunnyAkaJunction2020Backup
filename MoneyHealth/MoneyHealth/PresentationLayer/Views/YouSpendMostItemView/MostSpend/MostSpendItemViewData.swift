//
//  MostSpendItemViewData.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

enum Period: String {
    case week
    case month
    case year
}

struct MostSpendItemViewData: Hashable {

    let icon: UIImage
    
    let amount: Double
    
    let iconString: String

    let numberOfTransactions: Int
    
    let percent: Double
    
    let category: String

    let period: Period
}
