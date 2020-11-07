//
//  Category.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation

enum Category: String, Decodable, CaseIterable {
    case home
    case restaurants
    case pets
    case investments
    case insurance

    static var spendingCategories: [Category] {
        return [Category.home, .restaurants, .pets]
    }
    
    static var commitments: [Category] {
        return [Category.insurance]
    }

    static var healthyCategories: [Category] {
        return [Category.investments]
    }
}
