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
            if let data = json.data {
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

    func getBehavior(byId id: Int, for date: Date, period: Period) -> Single<[MostSpendItemModel]> {
        return Single<[MostSpendItemModel]>.create { single in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale.current
            let dateString = formatter.string(from: date)
            
            AF.request(
                "http://195.91.231.34:5000/user/insides/\(id)/last/\(period.rawValue)",
                method: .get
            ).responseJSON { [weak self] json in
                let parsedData = try! JSONSerialization.jsonObject(with: json.data!, options: .mutableLeaves) as! [String: AnyObject]
                
                let brand = parsedData["more_of_brand"] as! [String: AnyObject]
                let category = parsedData["more_of_category"] as! [String: AnyObject]
                
                let brandModel = BehaviourModel(
                    amount: brand["amount"] as! Double,
                    change: brand["change"] as! Double,
                    imageName: brand["image_name"] as! String,
                    category: brand["name"] as! String,
                    numberOfTransactions: brand["number_of_transactions"] as! Int
                )
                
                let categoryModel = BehaviourModel(
                    amount: category["amount"] as! Double,
                    change: category["change"] as! Double,
                    imageName: category["image_name"] as! String,
                    category: category["name"] as! String,
                    numberOfTransactions: category["number_of_transactions"] as! Int
                )
                
                let behaviors = [brandModel, categoryModel]
                
                let data = behaviors.map {
                    MostSpendItemViewData(
                        icon: UIImage(named: String($0.imageName.split(separator: ".")[0]))!,
                        amount: $0.amount,
                        numberOfTransactions: $0.numberOfTransactions,
                        percent: $0.change,
                        category: $0.category,
                        period: period
                    )
                }
                
                let models = data.map {
                    MostSpendItemModel(data: $0)
                }
                
                single(.success(models))
            
            }
            return Disposables.create()
        }
    }

    func getCategories(byId id: Int, for date: Date, period: Period) -> Single<[PopularCategoryItemModel]> {
        return Single<[PopularCategoryItemModel]>.create { single in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale.current
            let dateString = formatter.string(from: date)

            AF.request(
                "http://195.91.231.34:5000/user/popular_categories/\(id)/last/\(period.rawValue)",
                method: .get
            ).responseJSON { [weak self] json in
                let decoder = JSONDecoder()
                let categories = try! decoder.decode([PopularCategoryModel].self, from: json.data!)

                let data = categories.map {
                    return PopularCategoryItemViewData(
                        categoryImage: UIImage(named: String($0.image_name.split(separator: ".")[0]))!,
                        iconColor: .green,
                        categoryTitle: $0.name,
                        periodTitle: period.rawValue,
                        tendency: $0.change,
                        amount: $0.amount
                    )
                }

                let models = data.map {
                    return PopularCategoryItemModel(data: $0)
                }
                
                single(.success(models))
            }
            return Disposables.create()
        }
    }
}

