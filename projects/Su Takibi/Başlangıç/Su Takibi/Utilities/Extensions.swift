//
//  Extensions.swift
//  Su Takibi
//
//  Created by Emirhan Erdogan on 28.03.2020.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
}
