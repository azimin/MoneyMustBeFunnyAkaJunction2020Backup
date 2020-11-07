//
//  PopularCategoryItemViewData.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import UIKit

struct PopularCategoryModel: Decodable {
    let amount: Double
    let change: Double
    let image_name: String
    let name: String
}

struct PopularCategoryItemViewData: Hashable {
    
    let categoryImage: UIImage
    let iconColor: UIColor

    let categoryTitle: String
    let periodTitle: String
    let tendency: Double
    let amount: Double
}
