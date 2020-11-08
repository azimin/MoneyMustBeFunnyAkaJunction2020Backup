//
//  SubscriptionToStyleService.swift
//  MoneyHealth
//
//  Created by Alexander on 11/8/20.
//

import UIKit

class SubscriptionToStyleService {
    static func nameToColor(name: String) -> UIColor {
        let list: [String: UIColor] = [
            "App Store": UIColor(hex: "FFFFFF"),
            "Amazon Prime": UIColor(hex: "425995"),
            "Sony PlayStation Plus": UIColor(hex: "FDD330"),
            "New York Times": UIColor(hex: "000000"),
            "Disney+": UIColor(hex: "153987"),
            "Boro": UIColor(hex: "0969AE"),
            "Spotify": UIColor.black,
            "PlayStation Now": UIColor(hex: "000000"),
            "Tinder": UIColor(hex: "F8AFA9"),
            "Learn Now": UIColor(hex: "BE0E0E"),
            "Clean Me": UIColor(hex: "11A8DD"),
            "Qulean": UIColor(hex: "20A052")
        ]

        return list[name] ?? .black
    }

    static func nameToImage(name: String) -> UIImage? {
        let list: [String: String] = [
            "App Store": "App Store",
            "Amazon Prime": "Amazon Prime",
            "Sony PlayStation Plus": "Sony PlayStation Plus",
            "New York Times": "New York Times",
            "Disney+": "Disney+",
            "Boro": "Boro",
            "Spotify": "Spotify",
            "PlayStation Now": "Sony PlayStation Now",
            "Tinder": "Tinder",
            "Learn Now": "Learn Now",
            "Clean Me": "Clean Me",
            "Qulean": "Qulean"
        ]

        return UIImage(named: list[name] ?? "")
    }
}
