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
            Button("API request"){
                queryActivitySummary(startDate: Date.now, endDate: Date.now);
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

func queryActivitySummary(startDate: Date, endDate: Date) {
    let calendar = Calendar.current
//    let units: NSCalendar.Unit = [.day, .month, .year]
    
    
    var startDateCom = calendar.dateComponents([.year, .month, .day], from: Date.distantPast)
    startDateCom.calendar = calendar
    
    var endDateCom = calendar.dateComponents([.year, .month, .day], from: Date.now)
    endDateCom.calendar = calendar
    
    let predicate = HKQuery.predicate(forActivitySummariesBetweenStart: startDateCom, end: endDateCom)
//    let predicate = HKQuery.predicateForAct
    
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
            print("Exercise Time: \(summary.appleExerciseTime.doubleValue(for: .minute())) mins")
            print("Stand Hours: \(summary.appleStandHours.doubleValue(for: .count())) hours")
            print("Basal Energy Burned: \(summary.activeEnergyBurnedGoal.doubleValue(for: .count())) kcal")
//            print("Flights Climbed: \(summary.flightsClimbed.doubleValue(for: .count())) flights")
//            print("Step Count: \(summary.stepCount.doubleValue(for: .count())) steps")
//            print("Distance: \(summary.distance?.doubleValue(for: .meter()) ?? 0) meters")
        }
    }
    
    HKHealthStore().execute(query)
}

