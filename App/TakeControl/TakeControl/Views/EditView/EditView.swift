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
        ScrollView{
            VStack {
                RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                    .frame(height: 230)
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .customShadow()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                        .edgesIgnoringSafeArea(.bottom)
                    
                    LazyVStack {
                        ForEach(groups, id: \.self) { group in
                            NavigationLink(destination: EditGroupView()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(height: 60)
                                        .padding(.all)
                                    HStack {
                                        Circle()
                                            .frame(height: 50)
                                            .foregroundColor(Color.white)
                                            .overlay(Text("img"))
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(Color.white)
                                            
                                            Text("llala")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.leading)
                                        }
                                        .padding(.all, 8)
                                    }
                                    
                                    .padding([.horizontal, .top])
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                        

                }
                .frame(height: 800)
                .padding(.all, 30)
                .customShadow()
                .edgesIgnoringSafeArea(.bottom)
            }
        }

    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
