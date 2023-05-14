//
//  GoalsView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct GoalsView: View {
    @State private var week = ""
    @State private var month = ""
    @State private var quarter = ""
    @State private var year = ""
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Cons.backgrondColor).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                                .frame(height: 160)
                            
                                .customShadow()
                            VStack {
                                Text("Week goal:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title2) // or .headline, depending on the look you want
                                    .bold()
                                    .padding(.horizontal)
                                
                                
                                Spacer()
                            }
                            .padding(.top)
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 90)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                                .frame(height: 160)
                            
                                .customShadow()
                            VStack {
                                Text("Month goal:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title2) // or .headline, depending on the look you want
                                    .bold()
                                    .padding(.horizontal)
                                
                                
                                Spacer()
                            }
                            .padding(.top)
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                                .frame(height: 160)
                            
                                .customShadow()
                            VStack {
                                Text("Quarter goal:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title2) // or .headline, depending on the look you want
                                    .bold()
                                    .padding(.horizontal)
                                
                                
                                Spacer()
                            }
                            .padding(.top)
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                                .frame(height: 160)
                            
                                .customShadow()
                            VStack {
                                Text("Year goal:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title2) // or .headline, depending on the look you want
                                    .bold()
                                    .padding(.horizontal)
                                
                                
                                Spacer()
                            }
                            .padding(.top)
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                        
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}


struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
