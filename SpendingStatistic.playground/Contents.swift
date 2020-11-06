import Foundation


let dummyData: [String: Any] = [
    "transactions": [
        [
            "id": 1,
            "amount": -19.31,
            "balance": 5000,
            "date": 1604684920,
            "currency": "EUR",
            "category": "home"
        ],
        [
            "id": 2,
            "amount": -40,
            "balance": 4960,
            "date": 1604771320,
            "currency": "EUR",
            "category": "home"
        ],
        [
            "id": 3,
            "amount": -100,
            "balance": 4860,
            "date": 1604425720,
            "currency": "EUR",
            "category": "restaurants"
        ],
        [
            "id": 3,
            "amount": -25.36,
            "balance": 4834.64,
            "date": 1604429320,
            "currency": "EUR",
            "category": "restaurants"
        ],
        [
            "id": 4,
            "amount": -19.31,
            "balance": 4815.33,
            "date": 1604602120,
            "currency": "EUR",
            "category": "restaurants"
        ],
        [
            "id": 5,
            "amount": -1000,
            "balance": 3815.33,
            "date": 1604684920,
            "currency": "EUR",
            "category": "home"
        ],
        [
            "id": 6,
            "amount": 300,
            "balance": 4115.33,
            "date": 1604429320,
            "currency": "EUR",
            "category": "pets"
        ],
        [
            "id": 7,
            "amount": -15,
            "balance": 4100.33,
            "date": 1604432920,
            "currency": "EUR",
            "category": "insurance"
        ],
        [
            "id": 8,
            "amount": -19.33,
            "balance": 4081,
            "date": 1604440120,
            "currency": "EUR",
            "category": "investments"
        ],
        [
            "id": 9,
            "amount": -20,
            "balance": 4061,
            "date": 1604443720,
            "currency": "EUR",
            "category": "investments"
        ],
        [
            "id": 10,
            "amount": -5,
            "balance": 4056,
            "date": 1604447320,
            "currency": "EUR",
            "category": "investments"
        ],
        [
            "id": 11,
            "amount": -10000,
            "balance": 300000,
            "date": 1607802638,
            "currency": "EUR",
            "category": "home"
        ]
    ]
]


struct Transaction: Decodable {
    let id: Int

    let amount: Double

    let balance: Double

    let date: TimeInterval

    let currency: String
    let category: Category
}

enum Month: String, CaseIterable {
    
    case jan
    case feb
    case march
    case apr
    case may
    case june
    case july
    case aug
    case sep
    case oct
    case nov
    case dec
}

enum Category: String, Decodable, CaseIterable {
    case home
    case restaurants
    case pets
    case investments
    case insurance

    static var spendingCategories: [Category] {
        return [Category.home, .restaurants, .pets]
    }
    
    static var commitments: [Category] {
        return [Category.insurance]
    }

    static var healthyCategories: [Category] {
        return [Category.investments]
    }
}

struct MonthAmount {

    let month: Month

    let amount: Double

    var tendency: Double = 0

    let categories: [Category: Double]
}

struct Transactions: Decodable {
    let transactions: [Transaction]
}

let jsonData: NSData
jsonData = try! JSONSerialization.data(withJSONObject: dummyData, options: JSONSerialization.WritingOptions()) as NSData
let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
//print("json string = \(jsonString)")


let items: [Transaction]
let data = jsonData as! Data

items = try! JSONDecoder().decode(Transactions.self, from: data).transactions

func getSpending(forCategory category: Category, from transactions: [Transaction]) -> Double {
    return transactions
        .filter { $0.category == category }
        .map { $0.amount }
        .reduce(0, +)
}


func getMonthSpending(_ month: Month, from transactions: [Transaction]) -> MonthAmount? {
    let monthTransactions = transactions.sorted(by: { $0.date > $1.date })
        .filter {
            let monthInfo = Date(timeIntervalSince1970: $0.date).month
            return month.rawValue == monthInfo.lowercased()
        }

    guard !monthTransactions.isEmpty else { return nil }
    var categories = [Category: Double]()
    Category.allCases.forEach {
       categories[$0] = getSpending(forCategory: $0, from: monthTransactions)
    }

    let amount = categories.values.reduce(0, +)
    
    return MonthAmount(month: month, amount: amount, categories: categories)
}

func getTendency(previousValue: Double, nowValue: Double) -> Double {
    print(previousValue)
    print(nowValue)
    let delta = previousValue - nowValue
    let value = delta / previousValue * 100
    return value
}

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
}


var spends = Month.allCases.compactMap {
    getMonthSpending($0, from: items)
}



func addTendencyForSpends(_ spends: inout [MonthAmount]) {
    var firstItem = 0
    var secondItem = 1
    (0 ..< spends.count - 1).forEach { _ in
        let tendency = getTendency(previousValue: spends[firstItem].amount, nowValue: spends[secondItem].amount)
        spends[secondItem].tendency = tendency
        firstItem += 1
        secondItem += 1
    }
}

getTendencyForSpends(&spends)

spends.forEach {
    print($0.tendency)
}
