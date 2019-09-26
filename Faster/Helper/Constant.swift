//
//  Constant.swift
//  Faster
//
//  Created by Aleksandr Tsebrii on 9/6/19.
//  Copyright © 2019 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

struct Constant {
    
    // MARK: -
    struct Font {
        struct Size {
            static let light: CGFloat = 12
            static let regular: CGFloat = 22
            static let medium: CGFloat = 32
            static let heavy: CGFloat = 42
            static let extra: CGFloat = 60
        }
        
        struct Name {
            static let light = "AvenirNextCondensed-UltraLight"
            static let regular = "AvenirNextCondensed-Regular"
            static let medium = "AvenirNextCondensed-Medium"
            static let heavy = "AvenirNextCondensed-Heavy"
        }
    }
    
    struct kUserDefaults {
        static let highScoreData = "highScoreData"
    }
    
}
