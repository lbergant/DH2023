//
//  ChatView.swift
//  TakeControl
//
//  Created by Blaž Bergant on 14/05/2023.
//

import SwiftUI

//struct Message: Identifiable {
//    let id = UUID()
//    let text: String
//    let isCurrentUser: Bool
//}

struct Message: Identifiable, Equatable, Hashable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool

    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
}



struct ChatView: View {
    @State private var currentMessage = ""
    
    @State var responses : [Message] = []
    @State var responsesOut : [Message] = []
    @State var isAllowed : Int = -1
    
    @State var firstUser: Bool = true
    @State var firstAssistant : Bool = true

    var body: some View {
        let cgpt = ChatGPTAPI.init(responses: $responses, responsesOut: $responsesOut, isAllowed: $isAllowed)
    
        
        ZStack {
            Color(Cons.backgrondColor).edgesIgnoringSafeArea(.all)
            ScrollView {
                ScrollViewReader { scrollView in
                    ForEach(responsesOut) { message in
                        HStack {
                            if message.isCurrentUser {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                            } else {
                                Text(message.text)
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                Spacer()
                            }
                        }
                    }
                    .onChange(of: responsesOut) { newValue in
                        scrollView.scrollTo(newValue.last, anchor: .bottom)
                    }
                }
            }
            .padding(.horizontal ,30)
            .padding(.top, 40)

            VStack {
                Spacer()
                HStack {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .customShadow()
                            .frame(height: 45)
                        
                        TextField("Type your message here...", text: $currentMessage)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .frame(minHeight: CGFloat(30))
                            .padding(.all)
                    }.padding(.leading, 18)
                    
                    
                    Button(action: {
                        isAllowed = -1
                        if responses.isEmpty{
                            let goalData = GoalsView() //for the record za Health mamo api narjen ampak v simulatorju ni 0 health data, in je lazje tkole, weather api se pride.
                            let userPrompt = "Blaz has used up his allocated screen time for the News app today. He will try to convince you why you should allow him to use more screen time. You should decide whether he can or can not get more time. Be harsh when deciding, but grant him additional time if you sense real urgency in his message such as school and so on OR that he has done a lot of productive work throughout the day. Also make sure to Start the conversation with 'I allow you additional X minutes'... if you decide to grant user more time OR 'I do not allow you'... if you decide not to grant more time for the user! This is a very important rule! Do not make your response longer than 40 words!\nToday is Sunday and the weather is rainy. The temperature is 11 degrees Celsius. Blaz has walked a total of 5,354 steps today, which is 53% of his goal. He has to stand up for 5 more hours, to reach his standing goal. Here are his life goals. In the next year he wants to acheave: " + goalData.getYear() + " In the next wuarter: " + goalData.getQuarter() + " in the next month: " + goalData.getMonth() + " and in this week he needs to achieve: " + goalData.getWeek() + "\nHere are some examples below for you to help you with knowing how to respond(these examples are not the current examples): 1.user: I deserve more screen time because I've cleaned my room. GPT: Cleaning your room is good, Blaz, but it doesn't directly relate to the weather or your physical activity. Try to do something that aligns with these factors to earn more screen time. 2. user: I had a one hour walk today and I've cleaned my room. GPT: That's great, Blaz! A one hour walk is a good start, especially considering the pleasant weather. Can you tell me more about your day? Maybe there's something else you've done that could earn you more screen time. 3. user: I cleaned my room, had a one-hour walk, and studied for 3 hours. GPT: Excellent work, Blaz! You've been quite productive and active today. Given these factors, I'm granting you an additional 30 minutes of screen time on Instagram. Remember, balance is key! This prompt is only an instruction for you to know what is the case and what is your task. The next prompt will be already be written by the user trying to convince you. If you now understand the rules, just respond by \"i understand\" and wait for next prompts. DONT FORGET THAT YOUR ANSWERS SHOULD BE FUNNY!"
                            cgpt.stepConvo(userPrompt : userPrompt,first: true)
                            
                        }
                        
                        cgpt.stepConvo(userPrompt: currentMessage, first:false)
                        currentMessage = ""
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                    }
                    .padding(10)
                    .foregroundColor(.blue)
                    .background(Circle().padding(.all).foregroundColor(Color.white))
                    .customShadow()

                }
                .padding()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
