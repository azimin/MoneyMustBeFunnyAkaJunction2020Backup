//
//  Transitionable.swift
//  ARKitImageDetection
//
//  Created by Andrey Volodin on 07.11.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol Transitionable {
    func prepareForTransitionIn()
    func onTransitionIn(duration: TimeInterval)
    func onTransitionOut()
}
