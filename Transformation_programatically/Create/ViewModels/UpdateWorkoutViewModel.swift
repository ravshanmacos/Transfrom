//
//  UpdateWorkoutViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit
import Combine
import CoreData

class UpdateWorkoutViewModel: ObservableObject{
    lazy var fetchedResultsController: NSFetchedResultsController<WorkoutPart>? = getFetchedResultsController()
    private let workout: Workout
    private let coredataHelper: CoreDataHelper
    
    var workoutParts: [WorkoutPart] = []
    @Published var workoutPart: WorkoutPart?
    @Published var isAddWorkoutTapped: Bool = false
    
    init(_ workout: Workout, coredataHelper: CoreDataHelper) {
        self.workout = workout
        self.coredataHelper = coredataHelper
        loadData()
    }
    
    func loadData(){
        guard let fetchedResultsController else {return}
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Failed loading workout parts \(error)")
        }
    }
    
    func updateWorkoutParts(_ workoutPart: WorkoutPart, data: [String: Any]){
        let index = workoutParts.firstIndex(of: workoutPart)!
        workoutParts[index].name = (data["name"] as! String)
        workoutParts[index].duration = data["duration"] as! Double
        workoutParts.insert(workoutPart, at: index)
    }
    
    func getWorkout(_ indexPath: IndexPath)->WorkoutPart?{
        if let fetchedResultsController, let fetchedObjects = fetchedResultsController.fetchedObjects{
            self.workoutParts = fetchedObjects
            return workoutParts[indexPath.row]
        }
        return nil
    }
    
    func getWorkoutName()->String{
        return workout.name == nil ? "" : workout.name!
    }
    
    func getWorkoutDuration()->String{
        return String(workout.duration/60)
    }
    
    func getWorkoutPartsCount()-> Int{
        guard let fetchedResultsController, let fetchedObjects = fetchedResultsController.fetchedObjects else{
            return 0
        }
        return fetchedObjects.count
    }
}

//MARK: - Helper methods
extension UpdateWorkoutViewModel{
    
    func workoutDidUpdate(data: [String: Any]){
        coredataHelper.update(workout, data: data)
        isAddWorkoutTapped = true
    }
    
    func workoutPartDidSelect(workoutPart: WorkoutPart){
        self.workoutPart = workoutPart
    }
    
    private func getFetchedResultsController()-> NSFetchedResultsController<WorkoutPart>?{
        let fetchRequest: NSFetchRequest<WorkoutPart> = WorkoutPart.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(WorkoutPart.workout), workout)
        let sort = NSSortDescriptor(key: #keyPath(WorkoutPart.date), ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sort]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coredataHelper.getManagedContext(), sectionNameKeyPath: nil, cacheName: nil)
    }
}
