//
//  GoalsView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct GoalsView: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(Cons.backgrondColor)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("This is the first view")
                    NavigationLink(destination: SecondView()) {
                        Text("Go to second view")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .navigationTitle("First View")
            }
        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("This is the second view")
            .navigationTitle("Second View")
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
