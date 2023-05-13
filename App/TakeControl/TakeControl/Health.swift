//
//  Health.swift
//  TakeControl
//
//  Created by Luka Bergant on 13/05/2023.
//

import SwiftUI
import HealthKit

struct Health: View {
    @State var result : String = "";
    
    var body: some View {
        VStack{
            Text("Health")
            Text(result)
            Button("Init health API") {
                if initHealthAPI(){
                    result = "OK"
                }else{
                    result = "NOK"
                }
            }
            
        }
        
        
    }
}

struct Health_Previews: PreviewProvider {
    static var previews: some View {
        Health()
    }
}

func initHealthAPI()-> Bool{
    if HKHealthStore.isHealthDataAvailable() {
        return true
    }else{
        return false
    }
}
