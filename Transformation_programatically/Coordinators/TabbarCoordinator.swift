//
//  TabbarCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/14.
//

import UIKit

class TabbarCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = TabBarController(nibName: nil, bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

