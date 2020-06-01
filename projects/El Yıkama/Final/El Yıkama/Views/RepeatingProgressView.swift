//
//  RepeatingProgressView.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import SwiftUI

struct RepeatingProgressView: View {
    
    // MARK: - Properties
    @State var currentProgressWidth: CGFloat = 0
    
    // MARK: - UI Elements
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.progressGray)
            
            Rectangle()
                .foregroundColor(.darkBlue)
                .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: false))
                .frame(width: self.currentProgressWidth)
        }
        .frame(width: 295, height: 12)
        .cornerRadius(6)
        .onAppear {
            DispatchQueue.main.async {
                self.currentProgressWidth = 295
            }
        }
    }
}
