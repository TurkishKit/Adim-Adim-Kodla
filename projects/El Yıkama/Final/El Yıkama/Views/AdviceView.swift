//
//  AdviceView.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/22/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import SwiftUI

struct AdviceView: View {
    
    // MARK: - Properties
    let advice: Advice
    
    // MARK: - UI Elements
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 5) {
                Text("TAVSİYE")
                    .foregroundColor(.darkBlue)
                    .font(.system(size: 12, weight: .heavy))
                
                Text(advice.title)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            
            Divider()
            
            Text(advice.description)
                .foregroundColor(.darkGray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}
