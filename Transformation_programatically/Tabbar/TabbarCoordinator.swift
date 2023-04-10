//
//  TabbarCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/14.
//

import UIKit

class TabbarCoordinator: BaseCoordinator{
    //MARK: - Properties
    //coordinators
    private let startWorkout = WorkoutCategoryCoordinator(presenter: UINavigationController())
    private let createWorkout = CreateWorkoutCoordinator(presenter: UINavigationController())
    private let workoutProgress = WorkoutProgressCoordinator(presenter: UINavigationController())
    
    //MARK: - Actions
    override func start() {
        let tabbarVC = TabBarController()
        setupStarters()
        tabbarVC.setViewControllers(setupTabbarControllers(), animated: true)
        navigationController.pushViewController(tabbarVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
}

//MARK: - UIHelper Functions
extension TabbarCoordinator{
    
    private func setupStarters(){
        start(coordinator: startWorkout)
        start(coordinator: createWorkout)
        start(coordinator: workoutProgress)
    }
    
    private func setupTabbarControllers()->[UINavigationController]{
        let tabbar1 = UITabBarItem(title: "Start", image: .runImage.plain, selectedImage: .runImage.filled)
        startWorkout.navigationController.tabBarItem = tabbar1
        
        let tabbar2 = UITabBarItem(title: "Create", image: .plusImage.plain, selectedImage: .plusImage.filled)
        createWorkout.navigationController.tabBarItem = tabbar2
        
        let tabbar3 = UITabBarItem(title: "Progress", image: .chartImage.plain, selectedImage: .chartImage.filled)
        workoutProgress.navigationController.tabBarItem = tabbar3
        return [
            startWorkout.navigationController,
            createWorkout.navigationController,
            workoutProgress.navigationController
        ]
    }
}

