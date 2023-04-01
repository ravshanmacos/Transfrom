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
    var workout: Workout?
    var coredataHelper: CoreDataHelper?
    
    @Published var workoutPart: WorkoutPart?
    @Published var isWorkoutTapped: Bool = false
    
    init() {
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
    
    func workoutDidUpdate(data: [String: Any]){
        guard let coredataHelper, let workout else{return}
        coredataHelper.update(workout, data: data)
        isWorkoutTapped = true
    }
    
    func workoutPartDidSelect(workoutPart: WorkoutPart){
        self.workoutPart = workoutPart
    }
}

//MARK: - Helper methods
extension UpdateWorkoutViewModel{
    private func getFetchedResultsController()-> NSFetchedResultsController<WorkoutPart>?{
        guard let coredataHelper, let workout else { return nil}
        let fetchRequest: NSFetchRequest<WorkoutPart> = WorkoutPart.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(WorkoutPart.workout), workout)
        let sort = NSSortDescriptor(key: #keyPath(WorkoutPart.date), ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sort]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coredataHelper.getManagedContext(), sectionNameKeyPath: nil, cacheName: nil)
    }
}
