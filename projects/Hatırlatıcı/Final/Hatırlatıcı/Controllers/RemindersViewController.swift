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
        let selectedReminder = reminderManager.getAllReminders()[indexPath.row]
        
        let completeAction = UIContextualAction(style: .normal, title: nil, handler: { (_, _, completion) in
            completion(true)
            
            self.reminderManager.setComplete(reminder: selectedReminder)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        })
        
        completeAction.image = selectedReminder.isCompleted ? UIImage(systemName: "minus.circle.fill") : UIImage(systemName: "checkmark.circle.fill")
        completeAction.backgroundColor = selectedReminder.isCompleted ? .lightGray : .orange
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let reminderToDelete = reminderManager.getAllReminders()[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (_, _, completed) in
            completed(true)
            self.reminderManager.delete(reminder: reminderToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - Actions
    @IBAction func unwindFromAddReminder(_ segue: UIStoryboardSegue) {
        
        // TableView objesine yeni bir eleman geldiğini kullanıcıya göstermek için birinci ekrana döndükten 0.5 saniye sonra elemanın eklendiğini kullanıcıya gösteriyoruz.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let newIndexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
