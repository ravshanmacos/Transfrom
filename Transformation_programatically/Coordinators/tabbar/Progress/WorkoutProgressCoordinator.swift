//
//  WorkoutProgressCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit

class WorkoutProgressCoordinator: Coordinator{
    //MARK: - Properties
    
    //tabbar item
    private var title: String = "Progress"
    private var image: UIImage = UIImage
        .init(systemName: Constants.TabbarItemImages.chartImageString)!
    private var selectedStateImage: UIImage = UIImage
        .init(systemName: "\(Constants.TabbarItemImages.chartImageString).fill")!
    
    //required
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //MARK: - LifeCycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
   //MARK: - Actions
    func start() {
        let vc = ProgressWorkoutController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.title = "Progress"
        let tabbarItem = UITabBarItem()
        tabbarItem.title = title
        tabbarItem.image = image
        tabbarItem.selectedImage = selectedStateImage
        vc.tabBarItem = tabbarItem
        navigationController.pushViewController(vc, animated: true)
    }
}

//MARK: - Coordinating
extension WorkoutProgressCoordinator{
    func workoutTypeDidSelect(_ workoutType: String){
        let child = AnalysisCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.workoutType = workoutType
        childCoordinators.append(child)
        child.start()
    }
}
