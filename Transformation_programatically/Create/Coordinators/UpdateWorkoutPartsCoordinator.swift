//
//  EditWorkoutPartsCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/15.
//

import UIKit
import CoreData

class UpdateWorkoutPartsCoordinator: UpdateCoordinatorProtocol{
    
    //MARK: - Properties
    
    //required
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    //optionals
    var updateWorkoutPartsVC: UpdateWorkoutPartsController?
    weak var parentCoordinator: AddWorkoutCoordinator?
    var coredataHelper: CoreDataHelper?
    var workout: Workout?
    
    //MARK: - LifeCycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
   //MARK: - Actions
    func start() {
        let vc = UpdateWorkoutPartsController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.coredateHelper = coredataHelper
        vc.workout = workout
        navigationController.pushViewController(vc, animated: true)
        self.updateWorkoutPartsVC = vc
    }
    
    func workoutDidSave(){
        parentCoordinator?.onSaveTap()
    }
    
    func workoutPartDidUpdate(_ workoutPart: WorkoutPart, data: [String:Any]){
        guard let updateWorkoutPartsVC else{return}
        updateWorkoutPartsVC.updateWorkoutParts(with: workoutPart, data)
        navigationController.dismiss(animated: true)
    }
}

//MARK: - Coordinating
extension UpdateWorkoutPartsCoordinator{
    func EditWorkoutPart(_ workoutPart: WorkoutPart){
        let child = EditWorkoutPartCoordinator(presenter: navigationController, workoutPart: workoutPart)
        child.parentCoordinator = self
        child.start()
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
