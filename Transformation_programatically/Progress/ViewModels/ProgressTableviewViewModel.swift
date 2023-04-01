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
    lazy var fetchedResultsController: NSFetchedResultsController<Workout> = getWorkoutFetchedResultsController()
    @Published var workout: Workout?
    init() {
        loadData()
    }
    
    func loadData(){
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("error loading workouts \(error)")
        }
    }
    
    func setSelectedWorkout(with indexPath: IndexPath){
        workout = fetchedResultsController.object(at: indexPath)
    }
}

//MARK: - NSFetchedResultsController
extension ProgressTableviewViewModel{
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
