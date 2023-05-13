//
//  EditView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct EditView: View {
    var body: some View {
        NavigationView {
            List {
                // Replace with your list of apps
                Text("App 1")
                Text("App 2")
                Text("App 3")
            }
            .navigationBarTitle("App limits:")
            .navigationBarItems(trailing:
                NavigationLink(destination: EditView()) {
                    Text("Edit")
                }
            )
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
