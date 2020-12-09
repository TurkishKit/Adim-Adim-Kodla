//
//  ListSectionTitleView.swift
//  Butce
//
//  Created by Can Balkaya on 10/11/20.
//

import SwiftUI

struct ListSectionTitleView: View {
    
    // MARK: - Properties
    let text: String
    
    // MARK: - UI Elements
    var body: some View {
        Text(text)
            .padding(.leading)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.titleColor)
    }
}

struct ListSectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListSectionTitleView(text: "Son Harcamaların")
                .modifier(PreviewViewModifier(colorScheme: .dark))
            
            ListSectionTitleView(text: "Son Harcamaların")
                .modifier(PreviewViewModifier(colorScheme: .light))
        }
    }
}
