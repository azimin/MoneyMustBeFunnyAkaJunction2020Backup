//
//  ARImageStoreService.swift
//  MoneyHealth
//
//  Created by Alexander on 11/8/20.
//

import UIKit

class ARImageStoreService {
    static var shared = ARImageStoreService()

    var healthImage: UIImage? {
        return self.forceHealthImage
    }

    var forceHealthImage: UIImage?
}
