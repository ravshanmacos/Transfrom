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
    private let coredataHelper = CoreDataHelper.shared
    private lazy var fetchedResultsController: NSFetchedResultsController<Workout> = getWorkoutFetchedResultsController()
    private var workouts: [Workout] = []
    private lazy var selectedWorkout: Workout = {
       return workouts[0]
    }()
    @Published var isWorkoutsEmpty: Bool = true
    @Published var isNextBtnTapped: Bool = false
    
    init() {
        loadData()
    }
    
    func loadData(){
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
    func getCoreDataHelper()->CoreDataHelper{
        return coredataHelper
    }
    
    func getFRController()->NSFetchedResultsController<Workout>{
        return fetchedResultsController
    }
    
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
