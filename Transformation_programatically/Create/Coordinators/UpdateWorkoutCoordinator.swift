//
//  UpdateWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import UIKit
import CoreData

class UpdateWorkoutCoordinator: UpdateCoordinatorProtocol{
    //MARK: - Properties
    
    //required
    private let viewModel: UpdateWorkoutViewModel
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //optionals
    var updateWorkoutVC: UpdateWorkoutController?
    var coredataHelper: CoreDataHelper?
    var workout: Workout?
    
    
    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
        viewModel = UpdateWorkoutViewModel()
        viewModel.workout = workout
        viewModel.coredataHelper = coredataHelper
    }
    
    //MARK: - Actions
    func start() {
        let vc = UpdateWorkoutController(nibName: nil, bundle: nil)
        vc.title = "Update"
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
        self.updateWorkoutVC = vc
    }
    
    func workoutPartDidUpdate(_ workoutPart: WorkoutPart, data: [String:Any]) {
        guard let updateWorkoutVC else{return}
        updateWorkoutVC.updateWorkoutParts(with: workoutPart, data)
        navigationController.dismiss(animated: true)
    }
    
}

//MARK: - Coordinating
extension UpdateWorkoutCoordinator{
    func EditWorkoutPart(_ workoutPart: WorkoutPart){
        let vc = EditWorkoutPartController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.workoutPart = workoutPart
        navigationController.present(vc, animated: true)
    }
}


