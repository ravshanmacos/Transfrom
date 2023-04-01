//
//  TabBarController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit

class TabBarController: UITabBarController {
    //MARK: - Properties
    
    //coordinators
    let startWorkout = WorkoutCategoryCoordinator(presenter: UINavigationController())
    let createWorkout = CreateWorkoutCoordinator(presenter: UINavigationController())
    let workoutProgress = WorkoutProgressCoordinator(presenter: UINavigationController())
    
    //optionals
    weak var coordinator: TabbarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStarters()
        setupTabbarControllers()
    }
}

//MARK: - UIHelper Functions
extension TabBarController{
    
    private func setupStarters(){
        startWorkout.start()
        createWorkout.start()
        workoutProgress.start()
    }
    
    private func setupTabbarControllers(){
        viewControllers = [
            startWorkout.navigationController,
            createWorkout.navigationController,
            workoutProgress.navigationController
        ]
    }
}
