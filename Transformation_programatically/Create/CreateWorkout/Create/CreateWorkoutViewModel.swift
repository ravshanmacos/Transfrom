//
//  CreateWorkoutViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit
import Combine
import CoreData

class CreateWorkoutViewModel: ObservableObject{
    //core data properties
    private var workouts: [Workout] = []
    var fetchedResultsController: NSFetchedResultsController<Workout>?
    private let coreDataManager: CoreDataManager
    
    @Published var workout: Workout?
    @Published var isAddTapped:Bool = false
    
    init(_ coredataManager: CoreDataManager) {
        self.coreDataManager = coredataManager
        fetchedResultsController = coreDataManager.getWorkoutFetchedResultsControllerRequest()
        loadWorkouts()
    }
    
    func loadWorkouts(){
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
            print("failed performing fetch workouts\(error.localizedDescription)")
        }
    }
    
   
    
}

extension CreateWorkoutViewModel{
    func workoutDidSelect(_ workout: Workout){
        self.workout = workout
    }
    
    func workoutDidDelete(_ workout: Workout){
        coreDataManager.delete(workout)
    }
    
    func addWorkoutDidTap(){
        self.isAddTapped = true
    }
}
