//
//  SwiftUIView.swift
//  Butce Yonetimi
//
//  Created by Sergen Gonenc on 10/8/20.
//

import SwiftUI

struct BudgetInfoView: View {
    
    // MARK: - Properties
    var dailySpent: Int
    @Binding var expenseLimit: Int
    
    var progress: Double {
        Double(dailySpent) / Double(expenseLimit)
    }
    private var remainingBalance: Int {
        expenseLimit - dailySpent
    }
    
    // MARK: - UI Elements
    var body: some View {
        ZStack {
            CircleProgressView(progress: progress)
            
            VStack(spacing: 13) {
                VStack(spacing: 5) {
                    Text("\(dailySpent)₺")
                        .font(.system(size: 34, weight: .heavy, design: .rounded))
                    
                    Text("Bugün Harcanan")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.darkGray)
                }
                
                Divider()
                    .frame(width: 150)
                
                VStack(spacing: 5) {
                    Text("Kalan")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.darkGray)
                    
                    Text("\(remainingBalance)₺")
                        .font(.system(size: 23, weight: .heavy, design: .rounded))
                        .foregroundColor(remainingBalance > 0 ? .lightGreen : .red)
                }
            }
        }
    }
}

struct CircleProgressView: View {
    
    // MARK: - Properties
    @State var startAnimating = false
    var progress: Double
    
    // MARK: - UI Elements
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.lightBackground)
                .frame(width: 260, height: 260)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    
            Circle()
                .trim(from: CGFloat(startAnimating ? progress : 0), to: 1)
                .stroke(Color.lightPurple, style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
                .animation(.easeInOut(duration: 1))
                .frame(width: 260, height: 260)
                .rotationEffect(Angle(degrees: 270))
        }
        .onAppear {
            startAnimating = true
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BudgetInfoView(dailySpent: 20, expenseLimit: .constant(2000))
                .modifier(PreviewViewModifier(colorScheme: .dark))
            
            BudgetInfoView(dailySpent: 20, expenseLimit: .constant(2000))
                .modifier(PreviewViewModifier(colorScheme: .light))
        }
    }
}
