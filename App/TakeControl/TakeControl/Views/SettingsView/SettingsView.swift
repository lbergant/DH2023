//
//  SettingsView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct SettingsView: View {
    @State var healthApiResult = ""
    @StateObject var model = Model.shared
    @State var isPresented = false
    @State private var showChatGPTView = false
    
    var body: some View {
        let ha = HealthAPI.init(buttonText: $healthApiResult)
        
        VStack{
            Button("prva stvar - luka") {
                ha.initHealthAPI()
            }
            .padding(.all)
            Button("druga stvar - petr") {
                Task { await initScreenTimeAPI() }
            }
            .padding(.all)
            Button("tretja stvar - petr") {
                isPresented = true
            }
            .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
            .padding(.all)
            Button("lala - petr") {
                model.initiateMonitoring()
            }
            .padding(.all)
            Button("ChatGPT View") {
                    showChatGPTView = true
                }
                .padding()
        }
        .sheet(isPresented: $showChatGPTView) {
            ChatGPT()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
