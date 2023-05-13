//
//  TextTest.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct ButtonView: View {
    @Binding var buttonText: String
    
    var body: some View {
        Button(action: {
            buttonText = "Clicked"
        }) {
            Text("Click Me")
        }
    }
}


struct TextTest: View {
    @State private var textFieldText = ""
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $textFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("TextField Text: \(textFieldText)")
            
            ButtonView(buttonText: $textFieldText)
        }
        .padding()
    }
}


struct TextTest_Previews: PreviewProvider {
    static var previews: some View {
        TextTest()
    }
}
