//
//  HandWashStepsView.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import SwiftUI

struct HandWashStepsView: View {
    
    // MARK: - Properties
    @Binding var todaysHandWashCount: Int
    @State var currentStep = 1
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @Environment(\.presentationMode) var presentationMode
    @State private var isAlertPresented = false
    
    var allStepsCompleted: Bool {
        self.currentStep == dataStore.handWashSteps.count
    }
    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        ForEach(dataStore.handWashSteps.reversed(), id: \.index) { step -> AnyView in
                            let relativeIndex = step.index - self.currentStep
                            
                            switch relativeIndex {
                            case 0...2:
                                return AnyView(
                                        HandWashStepCardView(step: step)
                                            .offset(y: CGFloat(relativeIndex * -40))
                                            .scaleEffect(1 - CGFloat(relativeIndex) * 0.1)
                                    )
                            default:
                                return AnyView(EmptyView())
                            }
                        }
                        .padding(20)
                        .animation(.easeOut(duration: 1))
                    }
                    
                    RepeatingProgressView()
                        .padding(20)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button("Bitti") {
                self.isAlertPresented = true
            })
            .onReceive(self.timer) { _ in
                if self.allStepsCompleted {
                    self.todaysHandWashCount += 1
                    dataStore.increaseHandWashCount(self.todaysHandWashCount)
                    
                    self.timer.upstream.connect().cancel()
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.currentStep += 1
                }
            }
            .alert(isPresented: self.$isAlertPresented) {
                Alert(
                    title: Text("Çıkmak istediğinizden emin misiniz?"),
                    message: Text("Eğer şimdi çıkarsanız elinizi yıkadığınız sayılmayacak."),
                    primaryButton: .cancel(Text("Vazgeç")),
                    secondaryButton: .default(
                        Text("Eminim"),
                        action: {
                            self.timer.upstream.connect().cancel()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    )
                )
            }
        }
    }
}
