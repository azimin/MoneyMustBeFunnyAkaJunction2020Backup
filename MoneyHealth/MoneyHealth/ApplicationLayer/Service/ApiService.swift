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

    let user = BehaviorSubject<UserModel?>(value: nil)

    let userName = BehaviorSubject<String>(value: "")
    let userHealth = BehaviorSubject<Double>(value: 0)
    let userAvatarURL = BehaviorSubject<URL?>(value: nil)
    let userBalance = BehaviorSubject<Double>(value: 0)
    let subscrptionPayment = BehaviorSubject<Double?>(value: nil)

    let nextSubscriptions = BehaviorSubject<[SubscriptionModel]>(value: [])
    let activeSubscriptions = BehaviorSubject<[SubscriptionModel]>(value: [])
    let recommendedSubscriptions = BehaviorSubject<[RecommendedSubscriptionModel]>(value: [])
    
    static let shared = APIService()

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
                if let avatarURL = URL(string: person.userAvatatFullUrl) {
                    self?.userAvatarURL.onNext(avatarURL)
                }

                self?.user.onNext(person)
                
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
                guard let jsonData = json.data else {
                    return
                }
                let parsedData = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as! [String: AnyObject]
                
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
                        iconString: $0.imageName,
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
                guard let jsonData = json.data else {
                    return
                }

                let categories = try! decoder.decode([PopularCategoryModel].self, from: jsonData)

                let data = categories.map {
                    return PopularCategoryItemViewData(
                        categoryImage: UIImage(named: String($0.image_name.split(separator: ".")[0]))!,
                        iconColor: CategoryToColorMap.imageToColor(imageName: $0.image_name),
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

    // MARK: - Subscriptions

    func getNextSubscriptions(byUserId id: Int) -> Single<[SubscriptionModel]> {
        return Single<[SubscriptionModel]>.create { single in
            AF.request(
                "http://195.91.231.34:5000/user/next_two_subscriptions/\(id)/",
                method: .get
            ).responseJSON { [weak self] json in
                let decoder = JSONDecoder()
                guard let jsonData = json.data else {
                    return
                }

                let subscriptions = try! decoder.decode([SubscriptionModel].self, from: jsonData)
                self?.nextSubscriptions.onNext(subscriptions)
                single(.success(subscriptions))
            }
            return Disposables.create()
        }
    }

    func getActiveSubscriptions(byUserId id: Int) -> Single<[SubscriptionModel]> {
        return Single<[SubscriptionModel]>.create { single in
            AF.request(
                "http://195.91.231.34:5000/user/active_subscriptions/\(id)/",
                method: .get
            ).responseJSON { [weak self] json in
                let decoder = JSONDecoder()
                guard let jsonData = json.data else {
                    return
                }

                let subscriptions = try! decoder.decode([SubscriptionModel].self, from: jsonData)
                self?.activeSubscriptions.onNext(subscriptions)
                single(.success(subscriptions))
            }
            return Disposables.create()
        }
    }

    func getRecommendedSubscriptions(byUserId id: Int) -> Single<[RecommendedSubscriptionModel]> {
        return Single<[RecommendedSubscriptionModel]>.create { single in
            AF.request(
                "http://195.91.231.34:5000/user/subscription_prediction/\(id)/",
                method: .get
            ).responseJSON { [weak self] json in
                let decoder = JSONDecoder()
                guard let jsonData = json.data else {
                    return
                }

                let subscriptions = try! decoder.decode([RecommendedSubscriptionModel].self, from: jsonData)
                self?.recommendedSubscriptions.onNext(subscriptions)
                single(.success(subscriptions))
            }
            return Disposables.create()
        }
    }
}

