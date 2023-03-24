//
//  TabBarController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit

class TabBarController: UITabBarController {
    
    weak var coordinator: TabbarCoordinator?
    let startWorkout = WorkoutCategoryCoordinator(presenter: UINavigationController())
    let createWorkout = CreateWorkoutCoordinator(presenter: UINavigationController())
    let workoutProgress = WorkoutProgressCoordinator(presenter: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startWorkout.start()
        createWorkout.start()
        workoutProgress.start()
        viewControllers = [
            startWorkout.navigationController,
            createWorkout.navigationController,
            workoutProgress.navigationController
        ]
    }
    
    private func setupTabbarControllers(){}
}
