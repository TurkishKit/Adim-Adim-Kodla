//
//  HandWashStepCardView.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import SwiftUI

struct HandWashStepCardView: View {
    
    // MARK: - Properties
    let step: HandWashStep
    
    // MARK: - UI Elements
    var body: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 20) {
                VStack(spacing: 5) {
                    Text("ADIM \(step.index) / 12")
                        .foregroundColor(.darkBlue)
                        .font(.system(size: 12, weight: .heavy))
                    
                    Text(step.title)
                        .foregroundColor(.black)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Text(step.description)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                }
                
                Image(step.imageName)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .frame(height: 400)
                .shadow(color: Color.black.opacity(0.08), radius: 15, x: 0, y: -10)
        )
    }
}

