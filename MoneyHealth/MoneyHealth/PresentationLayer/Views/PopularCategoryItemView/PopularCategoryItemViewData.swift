//
//  PopularCategoryItemViewData.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

struct PopularCategoryItemViewData: Hashable {
    
    let categoryImage: UIImage

    let categoryTitle: String
    let periodTitle: String
    let tendency: Double
    let amount: Double
}
