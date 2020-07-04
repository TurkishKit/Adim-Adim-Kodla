//
//  ReminderTableViewCell.swift
//  Hatırlatıcı
//
//  Created by Sergen Gonenc on 6/21/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    
    // MARK: - Functions
    func prepare(with reminder: ReminderItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "tr")
        
        titleLabel.text = reminder.title
        dateLabel.text = dateFormatter.string(from: reminder.dueDate)
        tagView.backgroundColor = reminder.isCompleted ? .tagColorOn : .lightGray
    }
}
