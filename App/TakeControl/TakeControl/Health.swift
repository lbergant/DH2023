//
//  Health.swift
//  TakeControl
//
//  Created by Luka Bergant on 13/05/2023.
//

import SwiftUI
import HealthKit

let healthStore = HKHealthStore()

struct Health: View {
    @State var result = "";
    
    var body: some View {
        let ha = HealthAPI.init(buttonText: $result)
        
        VStack{
            Text("Health")
            Text(result)
            Button("Init health API") {
                ha.initHealthAPI()
            }
            Button("API request"){
                ha.queryActivitySummary();
            }
            
        }
        
        
    }
}

struct Health_Previews: PreviewProvider {
    static var previews: some View {
        Health()
    }
}

struct HealthAPI{
    @Binding var buttonText: String
    
    func handleAPIAuthorization(status : Bool){
        if status{
            buttonText = "OK"
        }else{
            buttonText = "NOK"
        }
    }
    
    func initHealthAPI(){
        if HKHealthStore.isHealthDataAvailable(){
            requestHealthKitAuthorization()
        }
    }
    
    func requestHealthKitAuthorization() {
        // Define the types of data you want to read
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.activitySummaryType()]
        
        // Request authorization from the user
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { (success, error) in
            handleAPIAuthorization(status: success)
        }
    }
    
    func queryActivitySummary() {
        let calendar = Calendar.current
        let endDate = Date.now
        //    let units: NSCalendar.Unit = [.day, .month, .year]
        
        

        
        var endDateCom = calendar.dateComponents([.year, .month, .day], from: endDate)
                endDateCom.calendar = calendar
        
        guard let startDate = calendar.date(byAdding: .day, value: -365, to: endDate) else {
            fatalError("*** Unable to create the start date ***")
        }
        var startDateCom = calendar.dateComponents([.year, .month, .day], from:startDate)
        startDateCom.calendar = calendar
        
        
        
        let predicate = HKQuery.predicate(forActivitySummariesBetweenStart: startDateCom, end: endDateCom)
        
        let query = HKActivitySummaryQuery(predicate: predicate) { (query, summaries, error) in
            if let error = error {
                print("Error querying activity summaries: \(error.localizedDescription)")
                return
            }
            
            guard let summaries = summaries else {
                return
            }
            
            for summary in summaries {
                // Access the activity summary data
                if let date = calendar.date(from: summary.dateComponents(for: calendar)){
                    print("Date: \(date.description)")
                }
                
                //                    summary.dateComponents(for: calendar).date
                
                print("Active Energy Burned: \(summary.activeEnergyBurned.doubleValue(for: .kilocalorie())) kcal")
//                print("Exercise Time: \(summary.appleExerciseTime.doubleValue(for: .minute())) mins")
//                print("Stand Hours: \(summary.appleStandHours.doubleValue(for: .count())) hours")
                print("Energy Goal: \(summary.activeEnergyBurnedGoal.doubleValue(for: .count())) kcal")
                //            print("Flights Climbed: \(summary.flightsClimbed.doubleValue(for: .count())) flights")
//                print("Step Count: \(summary.stepCount.doubleValue(for: .count())) steps")
                //            print("Distance: \(summary.distance?.doubleValue(for: .meter()) ?? 0) meters")
            }
        }
        
        healthStore.execute(query)
    }
    
}
