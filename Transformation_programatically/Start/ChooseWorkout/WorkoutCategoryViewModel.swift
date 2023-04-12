//
//  WorkoutCategoryViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/07.
//

import UIKit
import CoreData
import Combine

class WorkoutCategoryViewModel: ObservableObject{
    
    private var workouts: [Workout] = []
    private lazy var selectedWorkout: Workout = {
       return workouts[0]
    }()
    
    @Published var isWorkoutsEmpty: Bool = true
    @Published var isNextBtnTapped: Bool = false
    private var fetchedResultsController: NSFetchedResultsController<Workout>?
    var coredataManager: CoreDataManager?{
        didSet{
            self.fetchedResultsController = coredataManager?.getWorkoutFetchedResultsControllerRequest()
            loadData()
        }
    }
    
    func loadData(){
        guard let fetchedResultsController else {return}
        do {
            try fetchedResultsController.performFetch()
            if let fetchedObjects = fetchedResultsController.fetchedObjects, !fetchedObjects.isEmpty{
                workouts = fetchedObjects
                isWorkoutsEmpty = false
            }else{
                workouts.removeAll()
                isWorkoutsEmpty = true
            }
        } catch let error as NSError {
            print("error performing workouts fetch \(error)")
        }
    }
    
    func getWorkouts()->[Workout]{
        return workouts
    }
    
    func getWorkoutsCount()->Int{
        return workouts.count
    }
    
    func getWorkoutName(with row: Int)->String{
        if workouts.isEmpty{
            return "Empty"
        }
        let workout = workouts[row]
        return workout.name ?? ""
    }
    
    func setSelectedWorkout(row: Int){
        self.selectedWorkout = workouts[row]
    }
    
    func getSelectedWorkout()->Workout{
        return selectedWorkout
    }
}

//MARK: - Helper Methods
extension WorkoutCategoryViewModel{    
    func getFRController()->NSFetchedResultsController<Workout>?{
        return fetchedResultsController
    }
}
