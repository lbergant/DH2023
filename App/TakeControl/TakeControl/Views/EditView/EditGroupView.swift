//
//  EditGroupView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct EditGroupView: View {
    @StateObject var model = Model.shared
    @State var isPresented = false
    var body: some View {

        
        ZStack {
            Color(Cons.backgrondColor)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {//prva vrsta
                    Circle()
                        .foregroundColor(Color.white)
                        .customShadow()
                        .overlay(Image(systemName: "doc.text").resizable().frame(width: 37, height: 47).foregroundColor(Color(Cons.blue)))
                    
                    Spacer(minLength: 30)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .customShadow()
                            .frame(height: 45)
                        
                        Text("News app")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                    
                    
                }
                .frame(height: 105)
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                
                
                
                ZStack { //druga vrsta
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white)
                        .customShadow()
                    
                    VStack {
                        
                        HStack{
                            Text(" Your Apps")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.all)
                            
                            Button("Edit      "){
                                isPresented = true
                            }
                                .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
                                .padding(.all)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        HStack{
                            Text(" Time allowed")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.all)

                            Button("0 Min    "){}
                                .padding(.all)
                        }
                    }
                    
                }
                .frame(height: 70)
                .padding(.horizontal, 30)
                .padding(.vertical, 35)
                
                ZStack { //tretja vrsta
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white)
                        .customShadow()
                    
                    VStack {
                        
                        HStack{
                            Text("  Difficulty")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.all)
                            
                            Button("Low   "){}
                                .padding(.all)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        HStack{
                            Text("Use Calender    ")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.all)

                            Button("Yes   "){}
                                .padding(.all)
                        }
                    }
                    
                }
                .frame(height: 70)
                .padding(.horizontal, 30)
                .padding(.vertical, 35)
                
                Spacer()
            }
        }
    }
}

extension View {
    func customShadow() -> some View {
        self
            .shadow(color: Color.black.opacity(0.13), radius: 6, x: 4, y: 7)
            .shadow(color: Color.black.opacity(0.13), radius: 3, x: 1, y: 3)
            .shadow(color: Color.black.opacity(0.05), radius: 1, x: 1, y: 1)
            .shadow(color: Color.white.opacity(0.6), radius: 5, x: -5, y: -10)
            .shadow(color: Color.white.opacity(0.6), radius: 3, x: -1, y: -2)
    }
}
struct EditGroupView_Previews: PreviewProvider {
    static var previews: some View {
        EditGroupView()
    }
}
