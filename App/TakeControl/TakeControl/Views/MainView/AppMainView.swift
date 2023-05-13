//
//  AppMainView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct AppMainView: View {
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
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(2)
        }
        .background(Color.black)
    }
}

struct AppMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppMainView()
    }
}
