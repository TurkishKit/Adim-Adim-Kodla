//
//  Extensions.swift
//  Hatırlatıcı
//
//  Created by Can Balkaya on 6/30/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIColor {
    
    // MARK: - Properties
    static var orange: UIColor {
        return UIColor(named: #function)!
    }
}
