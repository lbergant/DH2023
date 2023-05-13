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
                ha.readStepsTakenToday { (steps, error) in
                    if let error = error {
                        print("Error retrieving steps taken: \(error.localizedDescription)")
                        return
                    }

                    if let steps = steps {
                        print("Steps taken today: \(steps)")
                        result = result + "Steps: \(steps) "
                    } else {
                        print("Steps data not available for today.")
                    }
                }
                
                ha.readStepGoal{(steps, error) in
                    if let error = error {
                        print("Error retrieving steps goal: \(error.localizedDescription)")
                        return
                    }
                    
                    if let steps = steps {
                        print("Steps goal: \(steps)")
                        result += "Goal: \(steps)"
                    } else {
                        print("Steps data goal not available for today.")
                        result = result + "/5000"
                    }
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

struct HealthAPI{
    @Binding var buttonText: String
    
    func handleAPIAuthorization(status : Bool){
        if status{
            buttonText = "OK "
        }else{
            buttonText = "NOK "
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
            HKObjectType.activitySummaryType(),
            HKObjectType.quantityType(forIdentifier: .stepCount)!]
        
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
        
        guard let startDate = calendar.date(byAdding: .day, value: -7, to: endDate) else {
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
                buttonText = buttonText + "Cal:\(summary.activeEnergyBurned.doubleValue(for: .kilocalorie()))"
//                print("Exercise Time: \(summary.appleExerciseTime.doubleValue(for: .minute())) mins")
//                print("Stand Hours: \(summary.appleStandHours.doubleValue(for: .count())) hours")
                print("Energy Goal: \(summary.activeEnergyBurnedGoal.doubleValue(for: .kilocalorie())) kcal")
                buttonText = buttonText + "/\(summary.activeEnergyBurnedGoal.doubleValue(for: .kilocalorie()))"
                //            print("Flights Climbed: \(summary.flightsClimbed.doubleValue(for: .count())) flights")
//                print("Step Count: \(summary.stepCount.doubleValue(for: .count())) steps")
                //            print("Distance: \(summary.distance?.doubleValue(for: .meter()) ?? 0) meters")
            }
        }
        
        healthStore.execute(query)
    }
    
    func readStepGoal(completion: @escaping (Double?, Error?) -> Void) {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            print("Step count type is not available.")
            completion(nil, nil)
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .mostRecent) { (query, result, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let result = result, let averageQuantity = result.averageQuantity() {
                let goal = averageQuantity.doubleValue(for: HKUnit.count())
                completion(goal, nil)
            } else {
                completion(nil, nil)
            }
        }
        
        healthStore.execute(query)
    }

    
    func readStepsTakenToday(completion: @escaping (Double?, Error?) -> Void) {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            print("Step count type is not available.")
            completion(nil, nil)
            return
        }

        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: startOfDay, intervalComponents: DateComponents(day: 1))

        query.initialResultsHandler = { query, statisticsCollection, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let statisticsCollection = statisticsCollection else {
                completion(nil, nil)
                return
            }

            statisticsCollection.enumerateStatistics(from: startOfDay, to: now) { statistics, _ in
                if let sum = statistics.sumQuantity() {
                    let steps = sum.doubleValue(for: HKUnit.count())
                    completion(steps, nil)
                } else {
                    completion(nil, nil)
                }
            }
        }

        healthStore.execute(query)
    }
    
}
