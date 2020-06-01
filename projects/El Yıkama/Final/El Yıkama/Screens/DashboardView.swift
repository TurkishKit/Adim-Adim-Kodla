//
//  DashboardView.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    
    // MARK: - Properties
    @State var yesterdaysHandWashCount = dataStore.yesterdaysHandWashCount
    @State var todaysHandWashCount = dataStore.todaysHandWashCount
    let advice = dataStore.advices.randomElement()!
    @State var isPresented = false
    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 40) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Durum Özeti")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            
                            HStack(spacing: 10) {
                                DaySummaryView(viewType: .yesterday, handWashCount: $yesterdaysHandWashCount)
                                DaySummaryView(viewType: .today, handWashCount: $todaysHandWashCount)
                            }
                        }
                        .padding(.top, 15)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Günün Bilgisi")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            
                            AdviceView(advice: advice)
                        }
                        
                        Button(action: {
                            self.isPresented = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.darkBlue)
                                    .frame(width: UIScreen.main.bounds.width - 30, height: 55)
                                
                                Text("Elini Yıka")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("El Yıkama")
            .sheet(isPresented: $isPresented, content: {
                HandWashStepsView(todaysHandWashCount: self.$todaysHandWashCount)
            })
            .onAppear {
                self.configureNotifications()
            }
        }
    }
    
    // MARK: - Functions
    func configureNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success {
                        let content = UNMutableNotificationContent()
                        content.title = "Elini Yıkadın mı?"
                        content.subtitle = "Elini sık sık yıkamalısın. Bunu unutmamanı sağlayacak bildirimlere izin veriyor musun?"
                        content.sound = UNNotificationSound.default
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4 * 60 * 60, repeats: true)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                    }
                }
            }
        }
    }
}
