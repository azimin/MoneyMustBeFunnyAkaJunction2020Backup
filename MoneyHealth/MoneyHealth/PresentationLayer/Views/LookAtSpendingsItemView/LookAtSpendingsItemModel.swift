//
//  LookAtSpendingsItemModel.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation
import RxCocoa
import RxSwift

final class LookAtSpendingsItemModel: GenericCellModel<LookAtSpendingItemView> {
    
    let items = BehaviorSubject<[SpendingItemModel]>(value: [])
}
