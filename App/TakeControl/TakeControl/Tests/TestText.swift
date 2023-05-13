//
//  TestText.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct TestText: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                .padding(.all)
            List(items, id: \.self) { item in
                Text(item)
                
            }
            
        }
        
        
        
    }
}





struct TestText_Previews: PreviewProvider {
    static var previews: some View {
        TestText()
    }
}
