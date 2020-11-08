//
//  SpendingViewData.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation

struct SpendingViewData: Hashable {
    enum Style {
        case ar
        case subsr
        case video
    }

    let title: String
    let imageUrl: URL
    let style: Style
}
