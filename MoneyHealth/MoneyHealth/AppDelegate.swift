//
//  AppDelegate.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 06.11.2020.
//

import UIKit
import FittedSheets

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let viewModel = MainViewModel()
        let mainVC = MainViewController(viewModel: viewModel)

        let subscriptionsViewModel = SubscriptionsViewModel()
        let subscriptionsVC = SubscriptionsViewController(viewModel: subscriptionsViewModel)

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .init(hex: "1A1A1A")
        tabBarController.tabBar.unselectedItemTintColor = .init(hex: "D1D1D1")
        tabBarController.viewControllers = [
            NavigationViewController.init(rootViewController: mainVC),
            NavigationViewController.init(rootViewController: subscriptionsVC)
        ]

        let appearance = tabBarController.tabBar.standardAppearance
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = .white
        tabBarController.tabBar.standardAppearance = appearance

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        NotificationCenter.default.addObserver(self, selector: #selector(self.showSubscription), name: .init(rawValue: "showSubsr"), object: nil)

        return true
    }

    @objc
    func showSubscription(notification: Notification) {
        guard let model = notification.object as? SubscriptionModel else {
            return
        }

        let viewController = self.window?.topViewController()

        let controller = SubscriptionDetailsViewController(subscription: model)
        let sheetController = SheetViewController(controller: controller)
        viewController?.present(sheetController, animated: true, completion: nil)
    }
}

