//
//  WorkoutCategoryCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit
import Combine

class WorkoutCategoryCoordinator: Coordinator{
    var title: String = "Start"
    var image: UIImage = UIImage.init(systemName: Constants.TabbarItemImages.runImageString)!
    var selectedStateImage: UIImage = UIImage.init(systemName: "\(Constants.TabbarItemImages.runImageString).fill")!
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    func start() {
        let vc = WorkoutCategoryController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.title = "Category"
        let tabbarItem = UITabBarItem()
        tabbarItem.title = title
        tabbarItem.image = image
        tabbarItem.selectedImage = selectedStateImage
        vc.tabBarItem = tabbarItem
        navigationController.pushViewController(vc, animated: true)
    }
    
    func workoutDidSelect(_ title: String){
        let child = StartWorkoutCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.selectedWorkoutTitle = title
        childCoordinators.append(child)
        child.start()
    }
}
