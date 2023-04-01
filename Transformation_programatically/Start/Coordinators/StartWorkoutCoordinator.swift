//
//  StartWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/14.
//

import UIKit

class StartWorkoutCoordinator: Coordinator{
    //MARK: - Properties
    //required
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //optionals
    weak var parentCoordinator: WorkoutCategoryCoordinator?
    var coredataHelper: CoreDataHelper?
    var selectedWorkout: Workout?
    
    private lazy var viewModel = {
       let viewModel = TimerViewModel(workoutParts: configureWorkout())
        viewModel.coredataHelper = coredataHelper
        return viewModel
    }()
    
    //MARK: - Life Cycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Actions
    func start() {
        let vc = StartWorkoutController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.viewModel = viewModel
        vc.title = "Start"
        vc.selectedWorkout = selectedWorkout
        navigationController.pushViewController(vc, animated: true)
    }
}

extension StartWorkoutCoordinator{
    private func configureWorkout()-> [WorkoutPart]{
        var workoutParts: [WorkoutPart] = []
        guard let selectedWorkout, let workoutPartsSet = selectedWorkout.workoutParts else{return workoutParts}
        workoutPartsSet.forEach({ el in
            let workoutPart = el as! WorkoutPart
            workoutParts.append(workoutPart)
        })
        return workoutParts
    }
}
