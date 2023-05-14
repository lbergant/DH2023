//
//  ChatGPT.swift
//  TakeControl
//
//  Created by Blaž Bergant on 14/05/2023.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
}

struct ChatGPT: View {
//    @State var lastResponse = ""
    @State var responses : [Message] = []
    
    var body: some View {
        var cgpt = ChatGPTAPI.init(responses: $responses)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Start conversation") {
            let userPrompt = "Can i give up"
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
    
    func responses2JSON()->[GPTConvo]{
        
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
        let requestBody = APIRequest(model: "gpt-3.5-turbo", messages: responses2JSON())
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
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                responses.append(Message.init(text: responseString ?? "", isCurrentUser: false))
                // You can parse the response data here
            }
        }

        // Start the API request
        task.resume()
    }
}
