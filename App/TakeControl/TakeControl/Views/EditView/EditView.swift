//
//  EditView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct EditView: View {

    let groups = ["Group 1", "Group 2", "Group 3", "Group 4", "Group 5"]

    var body: some View {
        List(groups, id: \.self) { group in
            
            Text(group)
        }
        .listStyle(SidebarListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
