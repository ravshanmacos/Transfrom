//
//  UpdateWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import UIKit
import CoreData

class UpdateWorkoutCoordinator: UpdateCoordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var updateWorkoutVC: UpdateWorkoutController?
    var coredataHelper: CoreDataHelper?
    var workout: Workout?
    weak var parentCoordinator: CreateWorkoutCoordinator?
    
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    func start() {
        let vc = UpdateWorkoutController(nibName: nil, bundle: nil)
        vc.title = "Update"
        vc.coordinator = self
        vc.coredataHelper = coredataHelper
        vc.workout = workout
        navigationController.pushViewController(vc, animated: true)
        self.updateWorkoutVC = vc
    }
    
    func EditWorkoutPart(_ workoutPart: WorkoutPart){
        let vc = EditWorkoutPartController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.workoutPart = workoutPart
        navigationController.present(vc, animated: true)
    }
    
    func workoutPartDidUpdate(_ workoutPart: WorkoutPart, data: [String:Any]) {
        guard let updateWorkoutVC else{return}
        let index = updateWorkoutVC.workoutParts.firstIndex(of: workoutPart)!
        updateWorkoutVC.workoutParts.remove(at: index)
        workoutPart.name = (data["name"] as! String)
        workoutPart.duration = data["duration"] as! Double
        updateWorkoutVC.workoutParts.insert(workoutPart, at: index)
        updateWorkoutVC.tableview.reloadData()
        navigationController.dismiss(animated: true)
    }
    
    func workoutDidSave(){
        parentCoordinator?.onSaveTap()
    }
    
}

extension UpdateWorkoutCoordinator{
    private func getWorkoutPartFetchedResultsController()-> NSFetchedResultsController<WorkoutPart>{
        let fetchRequest: NSFetchRequest<WorkoutPart> = WorkoutPart.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(WorkoutPart.workout), workout!)
        let sort = NSSortDescriptor(key: #keyPath(WorkoutPart.date), ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sort]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coredataHelper!.getManagedContext(), sectionNameKeyPath: nil, cacheName: nil)
    }
}
