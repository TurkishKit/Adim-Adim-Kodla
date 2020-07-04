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
    @IBOutlet weak var remindMeSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    // MARK: - Properties
    let dateLabelCellIndexPath = IndexPath(row: 1, section: 1)
    let datePickerCellIndexPath = IndexPath(row: 2, section: 1)
    
    var reminder: ReminderItem?
    let remindersManager = ReminderManager()
    var isDatePickerShown = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dateComponents = DateComponents()
        dateComponents.setValue(2, for: .minute)
        
        datePicker.minimumDate = Calendar.current.date(byAdding: dateComponents, to: Date())!
        updateDateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Sayfa ekrana gelmek üzereyken klavyenin açılmasını sağlar.
        titleTextField.becomeFirstResponder()
    }
    
    // MARK: - Functions
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // DatePicker elemanının içerisinde bulunduğu Cell objesi gözüktüğü zaman DatePicker
        // objesinin de gözükmesi için aşağıdaki kodlar ile Cell objesinin boyu ile oynuyoruz.
        switch indexPath {
        case dateLabelCellIndexPath:
            if remindMeSwitch.isOn {
                return 44
            } else {
                return 0
            }
            
        case datePickerCellIndexPath:
            if isDatePickerShown && remindMeSwitch.isOn {
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
        
        if indexPath == dateLabelCellIndexPath {
            isDatePickerShown.toggle()
            updateCells()
        }
    }
    
    func updateDateViews() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "tr")
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    func updateCells() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK: - Actions
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func remindMeSwitchValueChanged(_ sender: UISwitch) {
        if !sender.isOn {
            isDatePickerShown = false
        }
        
        updateCells()
    }
    
    @IBAction func cancelBarButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        var dueDate: Date?
        
        if remindMeSwitch.isOn {
            dueDate = datePicker.date
        }
        
        let newReminder = ReminderItem(title: titleTextField.text!, dueDate: dueDate)
        
        remindersManager.create(reminder: newReminder)
        performSegue(withIdentifier: "unwindToReminders", sender: nil)
    }
}

extension AddReminderViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if titleTextField.text != "" {
            addBarButton.isEnabled = true
        } else {
            addBarButton.isEnabled = false
        }
    }
}
