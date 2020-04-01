//
//  News.swift
//  Haberler
//
//  Created by Ufuk Köşker on 22.02.2020.
//  Copyright © 2020 Ufuk Köşker. All rights reserved.
//

import Foundation

struct News: Codable {
    
    // MARK: - Properties
    var title: String
    var pubDate: Date
    var link: String
    var thumbnail: String
    var categories: [String]
}
