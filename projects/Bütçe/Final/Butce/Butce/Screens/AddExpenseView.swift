//
//  AddExpenseView.swift
//  Butce
//
//  Created by Can Balkaya on 10/11/20.
//

import SwiftUI

struct AddExpenseView: View {
    
    // MARK: - Properties
    @StateObject var budgetManager = BudgetManager.shared
    @Binding var showSheet: Bool
    @State var expenseCost = 0
    @State var noteString = ""
    @State var selectedCategoryIndex = 0
    @State var isSelectable = false
    let categories = Category.all
    
    // MARK: - UI Elements
    var body: some View {
            NavigationView {
                Form {
                    Section(footer:
                        Text("Ne kadar para harcadığını gir.")
                    ) {
                        NumberTextField(value: $expenseCost)
                    }
                    
                    Section {
                        HStack(alignment: .center) {
                            Text("\(categories[selectedCategoryIndex].icon) \(categories[selectedCategoryIndex].name)")
                            
                            Spacer()
                            
                            Text(isSelectable ? "Bitir" : "Seç")
                                .foregroundColor(.lightPurple)
                                .onTapGesture {
                                    isSelectable.toggle()
                                }
                        }
                        
                        if isSelectable {
                            Picker("Kategori", selection: $selectedCategoryIndex) {
                                ForEach(categories.indices, id: \.self) { index in
                                    Text("\(categories[index].icon) \(categories[index].name)")
                                }
                            }
                            .pickerStyle(InlinePickerStyle())
                        }
                    }
                    
                    Section {
                        TextView(placeholderText: "Not", text: $noteString)
                            .frame(numLines: 3)
                    }
                }
                .navigationBarTitle("Harcama Ekle", displayMode: .inline)
                .navigationBarItems(
                    leading:
                        Button(action: {
                            showSheet = false
                        }) {
                            Text("Cancel")
                                .foregroundColor(.lightPurple)
                        },
                    
                    trailing:
                        Button(action: {
                            // Klavyeyi kapatır
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                            let expense = Expense(category: categories[selectedCategoryIndex], amount: expenseCost, date: Date(), note: noteString)
                            budgetManager.createExpense(expense)
                            expenseCost = 0
                            noteString = ""
                            showSheet = false
                        }) {
                            Text("Ekle")
                                .foregroundColor(.lightPurple)
                        }
                        .opacity(expenseCost == 0 ? 0.5 : 1)
                        .disabled(expenseCost == 0)
                )
            }
            .onTapGesture {
                // Klavyeyi kapatır
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(showSheet: .constant(false))
    }
}
