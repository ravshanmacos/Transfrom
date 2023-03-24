//
//  StartWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/14.
//

import UIKit

class StartWorkoutCoordinator: Coordinator{
    weak var parentCoordinator: WorkoutCategoryCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var selectedWorkoutTitle: String?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = StartWorkoutController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.title = "Start"
        vc.selectedWorkout = selectedWorkoutTitle
        navigationController.pushViewController(vc, animated: true)
    }
}
