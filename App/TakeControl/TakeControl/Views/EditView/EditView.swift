import SwiftUI
import SwiftUICharts

struct RepresentableCircular: UIViewRepresentable {
    let chart: Circular

    func makeUIView(context: Context) -> Circular {
        return chart
    }

    func updateUIView(_ uiView: Circular, context: Context) {
    }
}


struct EditView: View {

    let groups = ["News"]
    let chart = Circular(percentages: [42,58], colors: [.red, UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha:1)],aimationType: .animationFadeIn,showPercentageStyle: .none)

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
                                Text("Steps:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title2) // or .headline, depending on the look you want
                                    .bold()
                                    .padding(.horizontal)
                                
                                RepresentableCircular(chart: chart)
                                                                    .frame(width: 150, height: 150)
                                
                                Text("4800/10000")
                                    .frame(maxWidth: .infinity)
                                Spacer()
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
                                            .frame(height: 80)
                                            .padding(.horizontal)

                                    }
                                }
                                Spacer()
                            }
                            .frame(height: .infinity)
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
