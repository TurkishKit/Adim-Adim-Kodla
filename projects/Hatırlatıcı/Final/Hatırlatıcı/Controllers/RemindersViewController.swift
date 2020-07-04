//
//  ViewController.swift
//  Hatırlatıcı
//
//  Created by Sergen Gonenc on 6/21/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

class RemindersViewController: UITableViewController {
    
    // MARK: - Properties
    var reminderManager = ReminderManager()
    
    // MARK: - Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderManager.getAllReminders().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell") as? ReminderTableViewCell else {
            return UITableViewCell()
        }
        
        let reminder = reminderManager.getAllReminders()[indexPath.row]
        cell.prepare(with: reminder)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let currentReminder = reminderManager.getAllReminders()[indexPath.row]
        let title = currentReminder.isCompleted ? NSLocalizedString("Uncomplete", comment: "Uncomplete") : NSLocalizedString("Complete", comment: "Complete")
        
        let action = UIContextualAction(style: .normal, title: title, handler: { (action, view, completionHandler) in
            self.reminderManager.setComplete(reminder: currentReminder)
            
            // Hatırlatıcı tamamlandırıldıktan 0.8 saniye sonra tamamlandırıldığını göstermesi için aşağıdaki kodu yazdık.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.tableView.reloadData()
            }
            
            completionHandler(true)
        })

        action.image = currentReminder.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
        action.backgroundColor = currentReminder.isCompleted ? .lightGray : .tagColorOn
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // "editingStyle" değerinin "delete" olması durumunda aşağıdaki kodları çalıştırıyoruz.
        guard editingStyle == .delete else { return }
        let reminder = reminderManager.getAllReminders()[indexPath.row]
        
        reminderManager.delete(reminder: reminder)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - Actions
    @IBAction func unwindFromAddReminder(_ segue: UIStoryboardSegue) {
        
        // TableView objesine yeni bir eleman geldiğini kullanıcıya göstermek için birinci ekrana döndükten 0.5 saniye sonra elemanın eklendiğini kullanıcıya gösteriyoruz.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView.reloadData()
        }
    }
}
