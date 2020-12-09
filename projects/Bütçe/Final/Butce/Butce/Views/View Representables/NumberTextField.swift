//
//  NumberTextField.swift
//  Butce
//
//  Created by Can Balkaya on 11/1/20.
//

import SwiftUI

struct NumberTextField<V>: UIViewRepresentable where V: Numeric & LosslessStringConvertible {
    
    typealias UIViewType = UITextField
    
    // MARK: - Properties
    @Binding var value: V

    // MARK: - Functions
    func makeUIView(context: UIViewRepresentableContext<NumberTextField>) -> UITextField {
        let editField = UITextField()
        editField.delegate = context.coordinator
        editField.keyboardType = .numberPad
        
        return editField
    }

    func updateUIView(_ editField: UITextField, context: UIViewRepresentableContext<NumberTextField>) {
        editField.text = String(value)
    }

    func makeCoordinator() -> NumberTextField.Coordinator {
        Coordinator(value: $value)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        
        // MARK: - Properties
        var value: Binding<V>

        // MARK: - Life Cycle
        init(value: Binding<V>) {
            self.value = value
        }

        // MARK: - Functions
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let text = textField.text as NSString?
            let newValue = text?.replacingCharacters(in: range, with: string)

            if let number = V(newValue ?? "0") {
                self.value.wrappedValue = number
                
                return true
            } else {
                if nil == newValue || newValue!.isEmpty {
                    self.value.wrappedValue = 0
                }
                
                return false
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            if reason == .committed {
                textField.resignFirstResponder()
            }
        }
    }
}
