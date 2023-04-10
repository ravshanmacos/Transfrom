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
    private let coredataHelper = CoreDataHelper.shared
    private var workouts: [Workout] = []
    lazy var fetchedResultsController: NSFetchedResultsController<Workout> = getWorkoutFetchedResultsController()
    @Published var workout: Workout?
    
    init() {
        loadData()
    }
    
    func loadData(){
        do {
            try fetchedResultsController.performFetch()
            if let fetchedObjects = fetchedResultsController.fetchedObjects{
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
        workout = fetchedResultsController.object(at: indexPath)
    }
}

//MARK: - NSFetchedResultsController
extension ProgressTableviewViewModel{
    func getFRController()->NSFetchedResultsController<Workout>{
        return fetchedResultsController
    }
    
    func getCoreDataHelper()->CoreDataHelper{
        return coredataHelper
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
