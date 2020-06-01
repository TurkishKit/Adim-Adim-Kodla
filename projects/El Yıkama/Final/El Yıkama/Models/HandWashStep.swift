//
//  HandWashStep.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import Foundation

struct HandWashStep: Hashable, Codable {
    
    // MARK: - Properties
    let index: Int
    let title: String
    let description: String
    let imageName: String
}
