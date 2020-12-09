//
//  Provider.swift
//  ButceWidgetExtension
//
//  Created by Can Balkaya on 10/15/20.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    
    // MARK: - Properties
    let sharedDatas = UserDefaults(suiteName: SharedDatas.suitName)
    
    // MARK: - Functions
    func getExpenses() -> [Expense] {
        let documentsPath = FileManager.sharedContainerURL()
        let remindersPath = documentsPath.appendingPathComponent("expenses").appendingPathExtension("json")
        
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: remindersPath)
            let decodedExpenses = try! decoder.decode([Expense].self, from: data)

            return decodedExpenses
        } catch {
            return []
        }
    }
    
    func placeholder(in context: Context) -> BudgetEntry {
        BudgetEntry.placeholderSimpleEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (BudgetEntry) -> Void) {
        let entry = BudgetEntry.placeholderSimpleEntry
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<BudgetEntry>) -> Void) {
        let entry = BudgetEntry(expenses: getExpenses(), all: Category.all, expenseLimit: sharedDatas!.integer(forKey: SharedDatas.Keys.expenseLimit))

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
        
        WidgetCenter.shared.reloadAllTimelines()
    }
}
