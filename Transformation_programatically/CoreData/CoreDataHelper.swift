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
        for index in 0..<numberOfParts{
            let workoutPart = WorkoutPart(context: coreDataStack.managedContext)
            let formattedDuration = averageMinute(minutes: duration, numberOfParts: numberOfParts)
            workoutPart.name = "Edit Part - \(index)"
            workoutPart.duration = formattedDuration
            workoutPart.workout = workout
            workout.addToWorkoutParts(workoutPart)
        }
        coreDataStack.saveContext()
        return workout
    }
    
    func createWorkoutPart(_ name: String, _ duration: Double, date: Date = Date() )-> WorkoutPart{
        let workoutPart = WorkoutPart(context: coreDataStack.managedContext)
        workoutPart.name = name
        workoutPart.duration = duration
        workoutPart.date = date
        coreDataStack.saveContext()
        return workoutPart
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
    func averageMinute(minutes: Double,numberOfParts: Int)->Double{
        return minutes/Double(numberOfParts)
    }
}
