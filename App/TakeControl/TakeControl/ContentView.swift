//
//  ContentView.swift
//  TakeControl
//
//  Created by Luka Bergant on 13/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        TabView {
            HomePage().tabItem {
                Text("Domov")
                
            }.tag(1)
            
            Health().tabItem{
                Text("Health")
            }.tag(2)
            
            ScreenTime().tabItem {
                Text("Screen")
            }.tag(3)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
