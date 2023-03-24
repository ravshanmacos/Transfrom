//
//  TabbarCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/14.
//

import UIKit

class TabbarCoordinator: Coordinator{
    //MARK: - Properties
    //required
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //optionals
    weak var parentCoordinator: MainCoordinator?
    
    //MARK: - LifeCycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Actions
    func start() {
        let vc = TabBarController(nibName: nil, bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

