//
//  ScreenTime.swift
//  TakeControl
//
//  Created by Luka Bergant on 13/05/2023.
//

import SwiftUI
import FamilyControls

struct ScreenTime: View {
    @StateObject var model = Model.shared
    @State var isPresented = false
    
    var body: some View {
        VStack{
            Text("ScreenTime")
            Button("Init ScreenTime API") {
                Task { await initScreenTimeAPI() }
            }
            Button("Select Apps to Discourage") {
                isPresented = true
            }
            .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
            Button("Start Monitoring") {
                model.initiateMonitoring()
            }
            
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
