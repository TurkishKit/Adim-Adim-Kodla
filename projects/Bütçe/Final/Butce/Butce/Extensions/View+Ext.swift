//
//  View+Ext.swift
//  Butce
//
//  Created by Can Balkaya on 10/10/20.
//

import SwiftUI

extension View {
    
    // MARK: - Functions
    func toAnyView() -> AnyView {
        AnyView(self)
    }
    
    func presentation(isModal: Binding<Bool>, onDismissalAttempt: (() -> ())? = nil) -> some View {
        ModalView(view: self, isModal: isModal, onDismissalAttempt: onDismissalAttempt)
    }
}
