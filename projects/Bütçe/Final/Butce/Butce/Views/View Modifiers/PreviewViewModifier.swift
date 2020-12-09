//
//  PreviewViewModifier.swift
//  Butce
//
//  Created by Can Balkaya on 10/13/20.
//

import SwiftUI

struct PreviewViewModifier: ViewModifier {
    
    // MARK: - Properties
    let colorScheme: ColorScheme
    
    // MARK: - Functions
    func body(content: Content) -> some View {
        content
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.gray)
            .environment(\.colorScheme, colorScheme)
    }
}
