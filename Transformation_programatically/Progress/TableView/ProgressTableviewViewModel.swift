//
//  ProgressTableviewViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit
import CoreData
import Combine

class ProgressTableviewViewModel: ObservableObject{
    private var workouts: [Workout] = []
    var fetchedResultsController: NSFetchedResultsController<Workout>?
    var coreDataManager: CoreDataManager?{
        didSet{
            fetchedResultsController = coreDataManager?.getWorkoutFetchedResultsControllerRequest()
            loadData()
        }
    }
    @Published var workout: Workout?
    
    func loadData(){
        do {
            try fetchedResultsController?.performFetch()
            if let fetchedObjects = fetchedResultsController?.fetchedObjects{
                workouts = fetchedObjects
            }
        } catch let error as NSError {
            print("error loading workouts \(error)")
        }
    }
    
    func isWorkoutsEmpty()->Bool{
        return workouts.isEmpty
    }
    
    func getWorkoutsCount()->Int{
        guard !workouts.isEmpty else {return 1}
        return workouts.count
    }
    
    func getWorkoutName(at indexPath: IndexPath)->String{
        guard !workouts.isEmpty else { return "Oops empty"}
        return workouts[indexPath.row].name!
    }
    
    func setSelectedWorkout(with indexPath: IndexPath){
        workout = fetchedResultsController?.object(at: indexPath)
    }
}
