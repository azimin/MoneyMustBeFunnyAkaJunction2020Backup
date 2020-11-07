//
//  YouSpendMostItemModel.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation
import RxSwift

final class YouSpendMostItemModel: GenericCellModel<YouSpendMostItemView> {
    
    let items = BehaviorSubject<[MostSpendItemModel]>(value: [])
}
