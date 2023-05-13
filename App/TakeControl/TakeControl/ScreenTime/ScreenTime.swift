//
//  ScreenTime.swift
//  TakeControl
//
//  Created by Luka Bergant on 13/05/2023.
//

import SwiftUI
import FamilyControls

struct ScreenTime: View {
    var body: some View {
        VStack{
            Text("ScreenTime")
            Button("Init ScreenTime API") {
                Task { await initScreenTimeAPI() }
            }
//            Button("API request"){
//                queryActivitySummary(startDate: Date.now, endDate: Date.now);
//            }
            
        }
    }
}

struct ScreenTime_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTime()
    }
}

func initScreenTimeAPI() async {
    let center = AuthorizationCenter.shared
    do {
        try await center.requestAuthorization(for: .individual)
    } catch {
        print("Failed to init screenTime API \(error)")
    }
}
