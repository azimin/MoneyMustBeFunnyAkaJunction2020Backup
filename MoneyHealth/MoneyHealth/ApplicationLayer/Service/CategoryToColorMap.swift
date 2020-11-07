//
//  CategoryToColorMap.swift
//  MoneyHealth
//
//  Created by Alexander on 11/8/20.
//

import UIKit

class CategoryToColorMap {
    static func imageToColor(imageName: String) -> UIColor {
        let list: [String: UIColor] = [
            "1": UIColor(hex: "C75959"),
            "2": UIColor(hex: "4FCB4D"),
            "3": UIColor(hex: "944DCB"),
            "4": UIColor(hex: "4CBDED"),
            "5": UIColor(hex: "6BC7CD"),
            "6": UIColor(hex: "90ACAE"),
            "7": UIColor(hex: "936AA6"),
            "8": UIColor(hex: "63197C"),
            "9": UIColor(hex: "659CBB"),
            "10": UIColor(hex: "58C84E"),
            "11": UIColor(hex: "725078"),
            "12": UIColor(hex: "9BD76C"),
            "13": UIColor(hex: "6C45DB"),
            "14": UIColor(hex: "CF810C"),
            "15": UIColor(hex: "DC904A"),
            "16": UIColor(hex: "F23B3B"),
            "17": UIColor(hex: "3BC6F2"),
            "18": UIColor(hex: "D3C966"),
            "19": UIColor(hex: "4DBCFB"),
            "20": UIColor(hex: "29AAC7"),
        ]

        for (key, value) in list {
            if imageName.hasPrefix(key + ".png") {
                return value
            }
        }

        return .black
    }
}
