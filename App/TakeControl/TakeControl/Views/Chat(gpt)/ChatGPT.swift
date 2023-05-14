//
//  ChatGPT.swift
//  TakeControl
//
//  Created by Blaž Bergant on 14/05/2023.
//

import SwiftUI

struct ChatGPT: View {
//    @State var lastResponse = ""
    @State var responses : [Message] = []
    @State var isAllowed : Int = -1
    
    var body: some View {
        let cgpt = ChatGPTAPI.init(responses: $responses, isAllowed: $isAllowed)
        Text(String("Allowed for : \(isAllowed)"))
        Button("Init conversation") {
            isAllowed = -1
            let userPrompt = "Today's weather is sunny with a temperature of 22 degrees Celsius and Blaz has walked a total of 5,000 steps. Blaz has used up his allocated screen time for Instagram today. He will try to convince you why you should allow him to use more screen time. You should decide whether he can or can not get more time. Be semi harsh when deciding, but grant him additional time if you sense real urgency in his message such as school and so on OR that he has done a lot of productive work throughout the day. Also make sure to Start the conversation with 'I allow you additional X minutes'... if you decide to grant user more time OR 'I do not allow you'... if you decide not to grant more time for the user! This is a very important rule! Do not make your response longer than 40 words! Here are some examples below for you to help you with knowing how to respond(these examples are not the current examples): 1.user: I deserve more screen time because I've cleaned my room. GPT: Cleaning your room is good, Jure, but it doesn't directly relate to the weather or your physical activity. Try to do something that aligns with these factors to earn more screen time. 2. user: I had a one hour walk today and I've cleaned my room. GPT: That's great, Jure! A one hour walk is a good start, especially considering the pleasant weather. Can you tell me more about your day? Maybe there's something else you've done that could earn you more screen time. 3. user: I cleaned my room, had a one-hour walk, and studied for 3 hours. GPT: Excellent work, Jure! You've been quite productive and active today. Given these factors, I'm granting you an additional 30 minutes of screen time on Instagram. Remember, balance is key! This prompt is only an instruction for you to know what is the case and what is your task. The next prompt will be already be written by the user trying to convince you. If you now understand the rules, just respond by \"i understand\" and wait for next prompts.DONT FORGET THAT YOUR ANSWERS SHOULD BE FUNNY!"
            cgpt.stepConvo(userPrompt : userPrompt)
        }
        Button("Step conversation") {
            isAllowed = -1
            let userPrompt = "Can I use my favourite app for 15 minutes"
            cgpt.stepConvo(userPrompt : userPrompt)
        }
    }
}

struct ChatGPT_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPT()
    }
}

struct APIRequest: Codable {
    let model: String
    let messages: [GPTConvo]
}

struct GPTConvo: Codable{
    let role: String
    let content: String
}

struct ChatGPTAPI{
    @Binding var responses : [Message]
    @Binding var isAllowed : Int
    
    func responses2JSON(responses : [Message])->[GPTConvo]{
        
        var result : [GPTConvo] = []
        for res in responses{
            var user = ""
            if res.isCurrentUser{
                user = "user"
            }else{
                user = "assistant"
            }
            result.append(GPTConvo(role: user, content: res.text))
        }
        
        return result
    }
    
    func stepConvo(userPrompt : String){
        // Create a URL object with the endpoint you want to call
        guard let url = URL(string: "https://openai-api.meetings.bio/api/openai/chat/completions") else {
            print("Invalid URL")
            return
        }

        // Append user prompts
        responses.append(Message.init(text: userPrompt, isCurrentUser: true))
        
        
        // Create a URLRequest object with the URL
        var request = URLRequest(url: url)

        // Set the HTTP method (GET, POST, etc.)
        request.httpMethod = "POST"

//        // Optional: Set request headers if required
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + Secrets.apiToken, forHTTPHeaderField: "Authorization")

        // Optional: Set request body for POST requests
        // request.httpBody = ...
        let requestBody = APIRequest(model: "gpt-3.5-turbo", messages: responses2JSON(responses: responses))
        // Convert the request structure to JSON data
        guard let jsonData = try? JSONEncoder().encode(requestBody) else {
            print("Failed to encode API request")
            return
        }
        request.httpBody = jsonData

        // Create a URLSession object
        let session = URLSession.shared

        // Create a URLSessionDataTask to send the request
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Check the HTTP response status code
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            // Process the response data
            if let data = data {
                let responseString = String(data: data, encoding: .utf8) ?? ""
                print("Response: \(responseString)")
                responses.append(Message.init(text: responseString, isCurrentUser: false))
                checkAllowed(userPrompt: responseString)
                // You can parse the response data here
            }
        }
        
        // Start the API request
        task.resume()
    }
    
    func checkAllowed(userPrompt : String){
        // Create a URL object with the endpoint you want to call
        guard let url = URL(string: "https://openai-api.meetings.bio/api/openai/chat/completions") else {
            print("Invalid URL")
            return
        }
        
        let completePrompt = "below you have an answer. You have to figure out whether user has been allowed extra screen time or not. If it was allowed answer me in just two word like \"Yes 'number of minutes'\". For example if it has been allowed for 15 minutes, you should respond like \"Yes 15\". If it was not allowed just answer with \"No\". NO OTHER WORD IS ALLOWED! BE CAREFUL TO CONVERT TIME IN MINUTES! answer: \(userPrompt)"
        
        
        // Create a URLRequest object with the URL
        var request = URLRequest(url: url)

        // Set the HTTP method (GET, POST, etc.)
        request.httpMethod = "POST"

//        // Optional: Set request headers if required
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + Secrets.apiToken, forHTTPHeaderField: "Authorization")

        // Optional: Set request body for POST requests
        // request.httpBody = ...
        let requestBody = APIRequest(model: "gpt-3.5-turbo", messages: responses2JSON(responses: [Message(text: completePrompt, isCurrentUser: true)]))
        // Convert the request structure to JSON data
        guard let jsonData = try? JSONEncoder().encode(requestBody) else {
            print("Failed to encode API request")
            return
        }
        request.httpBody = jsonData

        // Create a URLSession object
        let session = URLSession.shared

        // Create a URLSessionDataTask to send the request
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Check the HTTP response status code
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            // Process the response data
            if let data = data {
                let responseString = String(data: data, encoding: .utf8) ?? ""
                print(responseString)
                if responseString.contains("No"){
                    print("Not Allowed")
                    isAllowed = -1
                }else{
                    print("Allowed")
                    var timeStr = responseString.split(separator: " ")[1]
                    isAllowed = Int(timeStr) ?? -1
                }
            }
        }
        task.resume()
    }
}
