//
//  NewsTableViewCell.swift
//  Haberler
//
//  Created by Ufuk Köşker on 22.02.2020.
//  Copyright © 2020 Ufuk Köşker. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
}
