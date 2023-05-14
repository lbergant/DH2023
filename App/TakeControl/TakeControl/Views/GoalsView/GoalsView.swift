//
//  GoalsView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct GoalsView: View {
    @State private var week = "Survive Monday to Friday, thrive on weekend."
    @State private var month = "Procrastinate wildly, panic later."
    @State private var quarter = "Set unrealistic goals, blame the universe."
    @State private var year = "Embrace chaos, blame it on Mercury."
    
    
    
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
                                HStack {
                                    Text("Week goal:")
                                        .foregroundColor(Color(Cons.blue))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.title2) // or .headline, depending on the look you want
                                        .bold()
                                    .padding(.horizontal)
                                    Spacer()
                                    Image(systemName: "plus").foregroundColor(Color(Cons.blue))
                                        .padding(.horizontal)
                                        .font(.system(size: 18, weight: .bold))
                                }
                                
                                
                                TextEditor(text: $week)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal)
                                
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
                                HStack {
                                    Text("Month goal:")
                                        .foregroundColor(Color(Cons.blue))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.title2) // or .headline, depending on the look you want
                                        .bold()
                                    .padding(.horizontal)
                                    Spacer()
                                    Image(systemName: "plus").foregroundColor(Color(Cons.blue))
                                        .padding(.horizontal)
                                        .font(.system(size: 18, weight: .bold))
                                }
                                
                                TextEditor(text: $month)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal)
                            }
                            .padding(.top)
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                                .frame(height: 160)
                            
                                .customShadow()
                            VStack {
                                HStack {
                                    Text("Quarter goal:")
                                        .foregroundColor(Color(Cons.blue))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.title2) // or .headline, depending on the look you want
                                        .bold()
                                    .padding(.horizontal)
                                    Spacer()
                                    Image(systemName: "plus").foregroundColor(Color(Cons.blue))
                                        .padding(.horizontal)
                                        .font(.system(size: 18, weight: .bold))
                                }
                                
                                
                                TextEditor(text: $quarter)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal)
                            }
                            .padding(.top)
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                                .frame(height: 160)
                            
                                .customShadow()
                            VStack {
                                HStack {
                                    Text("Year goal:")
                                        .foregroundColor(Color(Cons.blue))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.title2) // or .headline, depending on the look you want
                                        .bold()
                                    .padding(.horizontal)
                                    Spacer()
                                    Image(systemName: "plus").foregroundColor(Color(Cons.blue))
                                        .padding(.horizontal)
                                        .font(.system(size: 18, weight: .bold))
                                }
                                
                                
                                TextEditor(text: $year)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal)
                            }
                            .padding(.top)
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    func getYear() -> String {
            return self.year
        }

        func getQuarter() -> String {
            return self.quarter
        }

        func getMonth() -> String {
            return self.month
        }

        func getWeek() -> String {
            return self.week
        }
}


struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
