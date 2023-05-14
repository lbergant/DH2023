//
//  TestText.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct TestText: View {
        
        var body: some View {
            
            Image(systemName: "chevron.right")
        }
}





struct TestText_Previews: PreviewProvider {
    static var previews: some View {
        TestText()
    }
}



//List {
//    ForEach(responsesOut) { message in
//        HStack {
//            if message.isCurrentUser {
//                    Spacer()
//                    Text(message.text)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(20)
//            } else {
//                Text(message.text)
//                    .padding()
//                    .background(Color.gray)
//                    .foregroundColor(.white)
//                    .cornerRadius(20)
//                Spacer()
//            }
//        }
//    }
//}
//.listStyle(PlainListStyle())


//let groups = ["News"]
//
//var body: some View {
//    NavigationView {
//        List(groups, id: \.self) { group in
//            NavigationLink(destination: EditGroupView()) {
//                HStack {
//                    Circle()
//                        .frame(height: 50)
//                        .foregroundColor(Color.white)
//                        .customShadow()
//                        .overlay(Text("img"))
//                    
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 15)
//                            .foregroundColor(Color.white)
//                            .customShadow()
//                        Text("llala")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading)
//                            
//                        
//                    }
//                    .padding(.all, 8)
//                }
//            }
//        }
//        .listStyle(SidebarListStyle())
//    }
//}
