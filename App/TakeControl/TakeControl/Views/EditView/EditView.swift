import SwiftUI

struct EditView: View {

    let groups = ["News"]

    var body: some View {
        NavigationView {
            ZStack {
                Color(Cons.backgrondColor).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15).fill(Color.white).customShadow()
                                .frame(height: 230)
                                
                                .customShadow()
                            VStack {
                                Text("Stats:")
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
                                .edgesIgnoringSafeArea(.bottom)
                            
                            VStack {
                                Text("App limits:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title2) // or .headline, depending on the look you want
                                    .bold()
                                    .padding(.horizontal)
                                    .padding(.top)

                                ForEach(groups, id: \.self) { group in
                                    NavigationLink(destination: EditGroupView()) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                            HStack {
                                                Circle()
                                                    .foregroundColor(Color.white)
                                                    .overlay(Image(systemName: "doc.text").foregroundColor(Color.black))
                                                
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .foregroundColor(Color.white)
                                                    
                                                    Text("News app")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding(.leading)
                                                        .foregroundColor(Color.black)
                                                }
                                                Image(systemName: "chevron.right").foregroundColor(Color.white)

                                            }
                                            .padding(.all)
                                        }
                                            .frame(height: 78)
                                            .padding(.horizontal)

                                    }
                                }
                                Spacer()
                            }
                            .padding(.bottom)
                        }
                        .frame(height: 800)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        .customShadow()
                        .edgesIgnoringSafeArea(.bottom)
                    }
                    .padding(.bottom)
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
