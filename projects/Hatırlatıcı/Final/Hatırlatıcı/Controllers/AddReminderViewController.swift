//
//  AddReminderViewController.swift
//  Hatırlatıcı
//
//  Created by Sergen Gonenc on 6/22/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

class AddReminderViewController: UITableViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    // MARK: - Properties
    let dateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let datePickerCellIndexPath = IndexPath(row: 1, section: 1)
    var reminder: ReminderItem?
    
    let remindersManager = ReminderManager()
    
    var isDatePickerShown: Bool = false {
        didSet {
            
            // DatePicker objesinin gizli olup olmayacağını "isDatePickerShown" değerine göre belirliyoruz.
            datePicker.isHidden = !isDatePickerShown
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dateComponents = DateComponents()
        dateComponents.setValue(2, for: .minute)
        
        datePicker.minimumDate = Calendar.current.date(byAdding: dateComponents, to: Date())!
        updateDateViews()
    }
    
    // MARK: - Functions
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // DatePicker elemanının içerisinde bulunduğu Cell objesi gözüktüğü zaman DatePicker objesinin de gözükmesi için aşağıdaki kodlar ile Cell objesinin boyu ile oynuyoruz.
        switch indexPath {
        case datePickerCellIndexPath:
            if isDatePickerShown {
                return 216
            } else {
                return 0
            }
            
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case dateLabelCellIndexPath:
            if isDatePickerShown {
                isDatePickerShown = false
            } else {
                isDatePickerShown = true
            }
            
            // Cell objesine tıklandığında oluşan aksiyonların, güncellemeleri göstermek için aşağıdaki kodları yazdık.
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    func updateDateViews() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "tr")
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    // MARK: - Actions
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let newReminder = ReminderItem(title: titleTextField.text!, dueDate: datePicker.date)
        
        remindersManager.create(reminder: newReminder)
        performSegue(withIdentifier: "unwindToReminders", sender: nil)
    }
}

extension AddReminderViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if titleTextField.text != "" {
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
        }
    }
}
