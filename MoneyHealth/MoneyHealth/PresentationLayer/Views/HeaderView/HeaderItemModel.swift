//
//  HeaderItemModel.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation
import RxSwift
import RxCocoa

final class HeaderItemModel: GenericCellModel<HeaderView> {

    let imageURL = BehaviorSubject<URL?>(value: nil)
    let name = BehaviorSubject<String>(value: "")
    let rating = BehaviorSubject<Double>(value: 0.0)
    let balance = BehaviorSubject<Double>(value: 0.0)
}
