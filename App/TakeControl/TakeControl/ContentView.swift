//
//  ContentView.swift
//  TakeControl
//
//  Created by Luka Bergant on 13/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            GoalsView()
                .tabItem {
                    Image(systemName: "target")
                    Text("Goals")
                }
                .tag(0)
            EditView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Edit")
                }
                .tag(1)
            ChatView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Message")
                }
                .tag(2)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(3)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
