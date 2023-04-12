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
    var fetchedResultsController: NSFetchedResultsController<WorkoutPart>?
    private let workout: Workout
    private let coredataManager: CoreDataManager
    
    var workoutParts: [WorkoutPart] = []
    @Published var workoutPart: WorkoutPart?
    @Published var isAddWorkoutTapped: Bool = false
    
    init(_ workout: Workout, coredataManager: CoreDataManager) {
        self.workout = workout
        self.coredataManager = coredataManager
        fetchedResultsController = coredataManager.getWorkoutPartFetchedResultsControllerRequest(with: workout)
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
        coredataManager.update(workout, data: data)
        isAddWorkoutTapped = true
    }
    
    func workoutPartDidSelect(workoutPart: WorkoutPart){
        self.workoutPart = workoutPart
    }
}
