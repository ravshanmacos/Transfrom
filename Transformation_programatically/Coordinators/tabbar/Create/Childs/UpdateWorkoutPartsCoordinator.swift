//
//  EditWorkoutPartsCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/15.
//

import UIKit
import CoreData

class UpdateWorkoutPartsCoordinator: UpdateCoordinator{
    
    //MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var updateWorkoutPartsVC: UpdateWorkoutPartsController?
    weak var parentCoordinator: AddWorkoutCoordinator?
    var coredataHelper: CoreDataHelper?
    var workout: Workout?
    
    //MARK: - LifeCycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    //MARK: - Navigation Methods
    func start() {
        let vc = UpdateWorkoutPartsController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.coredateHelper = coredataHelper
        vc.workout = workout
        navigationController.pushViewController(vc, animated: true)
        self.updateWorkoutPartsVC = vc
    }
    
    func EditWorkoutPart(_ workoutPart: WorkoutPart){
        let vc = EditWorkoutPartController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.workoutPart = workoutPart
        navigationController.present(vc, animated: true)
    }
    
    func workoutPartDidUpdate(_ workoutPart: WorkoutPart, data: [String:Any]){
        guard let updateWorkoutPartsVC else{return}
        let index = updateWorkoutPartsVC.workoutParts.firstIndex(of: workoutPart)!
        updateWorkoutPartsVC.workoutParts.remove(at: index)
        workoutPart.name = (data["name"] as! String)
        workoutPart.duration = data["duration"] as! Double
        updateWorkoutPartsVC.workoutParts.insert(workoutPart, at: index)
        updateWorkoutPartsVC.tableview.reloadData()
        navigationController.dismiss(animated: true)
    }
    
    func workoutDidSave(){
        parentCoordinator?.onSaveTap()
    }
}

//MARK: - Helper methods
extension UpdateWorkoutPartsCoordinator{
    private func getWorkoutPartFetchedResultsController()-> NSFetchedResultsController<WorkoutPart>{
        let fetchRequest: NSFetchRequest<WorkoutPart> = WorkoutPart.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(WorkoutPart.workout), workout!)
        let sort = NSSortDescriptor(key: #keyPath(WorkoutPart.date), ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sort]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coredataHelper!.getManagedContext(), sectionNameKeyPath: nil, cacheName: nil)
    }
}
