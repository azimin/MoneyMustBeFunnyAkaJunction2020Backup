//
//  ApiService.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 07.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class APIService {

    let userName = BehaviorSubject<String>(value: "")
    let userHealth = BehaviorSubject<Double>(value: 0)
    let userAvatarURL = BehaviorSubject<URL?>(value: nil)
    let userBalance = BehaviorSubject<Double>(value: 0)
    let subscrptionPayment = BehaviorSubject<Double?>(value: nil)

    func getUser(byID id: Int) {
        AF.request(
            "http://195.91.231.34:5000/user/\(id)",
            method: .get
        ).responseJSON { [weak self] json in

            let decoder = JSONDecoder()
            let person = try! decoder.decode(UserModel.self, from: json.data!)

            self?.userName.onNext(person.user_name)
            self?.userHealth.onNext(person.user_health)
            if let avatarURL = URL(string: person.user_avatar_url) {
                self?.userAvatarURL.onNext(avatarURL)
            }
            
            self?.userBalance.onNext(person.user_balance)
            self?.subscrptionPayment.onNext(person.user_month_subscribtion_payment)
        }
    }
}

