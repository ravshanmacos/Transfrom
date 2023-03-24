//
//  AnalysisCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/15.
//

import UIKit

class AnalysisCoordinator: Coordinator{
    //MARK: - Properties
    //required
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //optionals
    weak var parentCoordinator: WorkoutProgressCoordinator?
    var workoutType: String?
    
    //MARK: - Life Cycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Actions
    func start() {
        let vc = AnalysisController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.workoutType = workoutType
        navigationController.pushViewController(vc, animated: true)
    }
}
