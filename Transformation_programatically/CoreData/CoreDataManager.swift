//
//  Helper.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/20.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    let coreDataStack: CoreDataStack = CoreDataStack(modelName: "Transformation")
    
    private init(){}
    
    func getManagedContext()-> NSManagedObjectContext{
        return coreDataStack.managedContext
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

//MARK: - Create
extension CoreDataManager{
    
    //Workout
    func createWorkout(_ name: String, _ duration: Double, _ numberOfParts: Int)-> Workout{
       let workout = Workout(context: coreDataStack.managedContext)
        let data: [String: Any] = ["date":Date(), "duration":duration, "name":name]
        update(workout, data: data)
        for index in 0..<numberOfParts{
            let workoutPart = WorkoutPart(context: coreDataStack.managedContext)
            let formattedDuration = averageMinute(minutes: duration, numberOfParts: numberOfParts)
            let data: [String: Any] = ["date":Date(), "duration":formattedDuration, "name":"Edit Part - \(index)"]
            workoutPart.workout = workout
            update(workoutPart, data: data)
            workout.addToWorkoutParts(workoutPart)
        }
        coreDataStack.saveContext()
        return workout
    }
    
    
    //Workout Part
    func createWorkoutPart(_ name: String, _ duration: Double, date: Date = Date() )-> WorkoutPart{
        let workoutPart = WorkoutPart(context: coreDataStack.managedContext)
        let data: [String: Any] = ["date":date, "duration":duration, "name":name]
        update(workoutPart, data: data)
        coreDataStack.saveContext()
        return workoutPart
    }
    
    //Done Workout
    func createDoneWorkout(_ date: Date = Date(), _ image: Data? = nil, _ percentage: Double = 0)->DoneWorkout{
        let doneWorkout = DoneWorkout(context: coreDataStack.managedContext)
        let data: [String: Any] = ["date": date, "image": image as Any, "percentage": percentage]
        update(doneWorkout, data: data)
        coreDataStack.saveContext()
        return doneWorkout
    }
}

//MARK: - Add

extension CoreDataManager{
    func add(to parentObject: NSManagedObject, childoObject: NSManagedObject){
        
    }
}


//MARK: - Read
extension CoreDataManager{
    func getWorkoutFetchedResultsControllerRequest()->NSFetchedResultsController<Workout>{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Workout.date), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        return getWorkoutFetchedResultsController(fetchRequest)
    }
    
    func getWorkoutPartFetchedResultsControllerRequest(with workout: Workout)-> NSFetchedResultsController<WorkoutPart>{
        let fetchRequest: NSFetchRequest<WorkoutPart> = WorkoutPart.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(WorkoutPart.workout), workout)
        let sort = NSSortDescriptor(key: #keyPath(WorkoutPart.date), ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sort]
        return getWorkoutFetchedResultsController(fetchRequest)
    }
    
    private func getWorkoutFetchedResultsController<T: NSManagedObject>(_ fetchRequest: NSFetchRequest<T>)-> NSFetchedResultsController<T>{
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        return fetchedResultsController
    }
    
    func fetchWorkouts()->[Workout]{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        return fetch(fetchRequest)
    }
    
    func fetchWithPredicate(predicate: NSPredicate)->[Workout]{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.predicate = predicate
        return fetch(fetchRequest)
    }
    
    private func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>)->[T]{
        do {
            let result = try coreDataStack.managedContext.fetch(request)
            return result
        } catch let error as NSError {
            print("Failed fetching \(error)")
            return []
        }
    }
}

//MARK: - helper Methods
extension CoreDataManager{
    func averageMinute(minutes: Double,numberOfParts: Int)->Double{
        return minutes/Double(numberOfParts)
    }
}
