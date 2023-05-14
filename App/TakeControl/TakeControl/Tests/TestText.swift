//
//  TestText.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct TestText: View {
    @State private var messages: [Message] = [Message(text: "yes", isCurrentUser: true),
                                              Message(text: "no", isCurrentUser: false)]
    @State private var currentMessage = ""

    var body: some View {
        VStack {
            List {
                ForEach(messages) { message in
                    HStack {
                        if message.isCurrentUser {
                            Spacer()
                            Text(message.text)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        } else {
                            Text(message.text)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            Spacer()
                        }
                    }
                }
            }

            HStack {
                TextField("Type your message here...", text: $currentMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                
                Button(action: {
                    messages.append(Message(text: currentMessage, isCurrentUser: true))
                    currentMessage = ""
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .padding(10)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())

            }
            .padding()
        }
    }
}





struct TestText_Previews: PreviewProvider {
    static var previews: some View {
        TestText()
    }
}
