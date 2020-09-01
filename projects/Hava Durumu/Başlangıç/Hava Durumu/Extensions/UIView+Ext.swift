//
//  UIView+Ext.swift
//  Hava Durumu
//
//  Created by Can Balkaya on 8/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import MapKit

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
