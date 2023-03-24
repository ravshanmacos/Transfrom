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
    var selectedWorkoutTitle: String?
    
    //MARK: - Life Cycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Actions
    func start() {
        let vc = StartWorkoutController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.title = "Start"
        vc.selectedWorkout = selectedWorkoutTitle
        navigationController.pushViewController(vc, animated: true)
    }
}
