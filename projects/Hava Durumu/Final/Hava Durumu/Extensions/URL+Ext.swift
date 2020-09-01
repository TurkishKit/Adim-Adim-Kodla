//
//  UIStoryboard+Ext.swift
//  Hava Durumu
//
//  Created by Can Balkaya on 8/25/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

extension URL {
    
    // MARK: - Functions
    func withQueries(_ queries: [String : String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        
        return components?.url
    }
}
