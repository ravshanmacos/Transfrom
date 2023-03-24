//
//  AnalysisCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/15.
//

import UIKit

class AnalysisCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: WorkoutProgressCoordinator?
    var workoutType: String?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = AnalysisController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.workoutType = workoutType
        navigationController.pushViewController(vc, animated: true)
    }
}
