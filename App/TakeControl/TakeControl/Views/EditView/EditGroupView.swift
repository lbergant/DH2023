//
//  EditGroupView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct EditGroupView: View {
    var body: some View {
        @State var enteredText: String = ""
        
        VStack{
            HStack {
                Circle()
                    .foregroundColor(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 5)
                    .overlay(Text("choosen\nimage"))
                
                Spacer(minLength: 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 5)
                        .frame(height: 50)
                    
                    TextField("Choosen group name", text: $enteredText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                }


            }
            .padding(.all)
            .frame(height: 150)
            
            RoundedRectangle(cornerRadius: 10)
                .padding(.horizontal, 40)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 5)
                .frame(height: 80)
        }
    }
}

struct EditGroupView_Previews: PreviewProvider {
    static var previews: some View {
        EditGroupView()
    }
}
