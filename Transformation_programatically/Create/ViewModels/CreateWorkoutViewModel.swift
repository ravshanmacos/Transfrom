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
    lazy var coredataHelper = CoreDataHelper.shared
    lazy var fetchedResultsController: NSFetchedResultsController<Workout> = getWorkoutFetchedResultsController()
    @Published var workout: Workout?
    @Published var isAddTapped:Bool = false
    
    init() {
        loadWorkouts()
    }
    
    func loadWorkouts(){
        do {
            try fetchedResultsController.performFetch()
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
        coredataHelper.delete(workout)
    }
    
    func addWorkoutDidTap(){
        self.isAddTapped = true
    }
}





//MARK: - Helper Methods
extension CreateWorkoutViewModel{
    private func getWorkoutFetchedResultsController()-> NSFetchedResultsController<Workout>{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Workout.date), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coredataHelper.getManagedContext(),
            sectionNameKeyPath: nil,
            cacheName: nil)
        return fetchedResultsController
    }
}
