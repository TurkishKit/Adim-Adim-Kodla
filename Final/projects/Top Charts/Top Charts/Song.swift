//
//  Song.swift
//  Top Charts
//
//  Created by Sergen Gonenc on 1/28/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

struct Song: Decodable {
    // MARK: - Properties
    let name: String
    let artistName: String
    let artworkUrl100: String
    let url: String
}
