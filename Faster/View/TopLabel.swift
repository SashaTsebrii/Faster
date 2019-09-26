//
//  TopLabel.swift
//  Faster
//
//  Created by Aleksandr Tsebrii on 9/7/19.
//  Copyright © 2019 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class TopLabel: UILabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners([.topLeft, .topRight], radius: 4)
    }

}
