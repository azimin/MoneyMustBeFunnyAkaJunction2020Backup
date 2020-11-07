//
//  UserModel.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation

struct UserModel: Decodable {

    let user_name: String
    let user_health: Double
    let user_avatar_url: String
    let user_balance: Double
    let user_month_subscribtion_payment: Double?
}
