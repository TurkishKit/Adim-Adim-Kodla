//
//  Extensions.swift
//  Top Charts
//
//  Created by Emirhan Erdogan on 28.01.2020.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    // MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    // MARK: - Functions
    func setImage(fromUrl url: URL) {
        kf.setImage(with: url)
    }
}
