//
//  Helper.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/20.
//

import Foundation
import CoreData

class CoreDataHelper{
    
    static let shared = CoreDataHelper()
    private let coreDataStack: CoreDataStack = CoreDataStack(modelName: "Transformation")
    
    private init(){}
    
    func getManagedContext()-> NSManagedObjectContext{
        return coreDataStack.managedContext
    }
    
    func create(_ name: String, _ duration: Double, _ numberOfParts: Int)-> Workout{
       let workout = Workout(context: coreDataStack.managedContext)
        workout.name = name
        workout.duration = duration
        workout.done = false
        for index in 0..<numberOfParts{
            let workoutPart = WorkoutPart(context: coreDataStack.managedContext)
            let formattedDuration = formatDurationInMinutes(with: duration, numberOfParts: numberOfParts)
            workoutPart.name = "Edit Part - \(index)"
            workoutPart.duration = formattedDuration
            workoutPart.workout = workout
            workout.addToWorkoutParts(workoutPart)
        }
        coreDataStack.saveContext()
        return workout
    }
    
    func fetchWithPredicate(predicate: NSPredicate)->[Workout]{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.predicate = predicate
        do {
           let workouts = try coreDataStack.managedContext.fetch(fetchRequest)
            return workouts
        } catch let error as NSError {
            print("failed to load workouts \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchAll()-> [Workout]{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        do {
           let workouts = try coreDataStack.managedContext.fetch(fetchRequest)
            return workouts
        } catch let error as NSError {
            print("failed to load workouts \(error.localizedDescription)")
            return []
        }
    }
    
    func update<T: NSManagedObject>(_ object: T, data: [String: Any]){
        for (key,value) in data{
            object.setValue(value, forKey: key)
        }
        coreDataStack.saveContext()
    }
    
    func delete<T: NSManagedObject>(_ object: T){
        coreDataStack.managedContext.delete(object)
        coreDataStack.saveContext()
    }
    
   
}

//MARK: - helper Methods
extension CoreDataHelper{
    func formatDurationInMinutes(with seconds: Double, numberOfParts: Int)-> Double{
        var minutes = seconds / 60
        minutes = averageMinute(minutes: minutes, numberOfParts: numberOfParts)
        return minutes
    }
    
    func averageMinute(minutes: Double,numberOfParts: Int)->Double{
        return minutes/Double(numberOfParts)
    }
}
