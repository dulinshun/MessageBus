//
//  UIColor+Random.swift
//  MessageBus_Example
//
//  Created by Tomorrow on 2024/3/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
