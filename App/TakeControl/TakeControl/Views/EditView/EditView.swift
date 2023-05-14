//
//  EditView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct EditView: View {

    let groups = ["News"]

    var body: some View {
        NavigationView {
            List(groups, id: \.self) { group in
                NavigationLink(destination: EditGroupView()) {
                    HStack {
                        Circle()
                            .frame(height: 50)
                            .foregroundColor(Color.white)
                            .customShadow()
                            .overlay(Text("img"))
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color.white)
                                .customShadow()
                            Text("llala")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                
                            
                        }
                        .padding(.all, 8)
                    }
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
