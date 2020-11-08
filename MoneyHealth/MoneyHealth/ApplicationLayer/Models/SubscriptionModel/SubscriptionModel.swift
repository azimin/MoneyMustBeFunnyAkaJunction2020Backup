//
//  SubscriptionModel.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit

struct SubscriptionModel: Decodable {
    var name: String
    var category: String

    var amount: CGFloat
    var isAvarage: Bool {
        return Bool(isAvarageString) ?? false
    }
    var isAvarageString: String

    var total: CGFloat
    var nextChargeString: String

    var nextCharge: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        return formatter.date(from: self.nextChargeString) ?? Date()
    }

    enum CodingKeys: String, CodingKey {
        case name = "service name"
        case category = "service category"
        case amount
        case total = "total_spend"
        case isAvarageString = "is_avarage"
        case nextChargeString = "next_charge"
    }

    var image: UIImage? {
        return SubscriptionToStyleService.nameToImage(name: self.name)
    }

    var backgroundColor: UIColor {
        return SubscriptionToStyleService.nameToColor(name: self.name)
    }
}
