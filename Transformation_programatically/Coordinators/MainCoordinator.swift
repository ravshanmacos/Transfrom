//
//  MainCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit
import Combine

class MainCoordinator: Coordinator{
    
    //MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //MARK: - Lifecycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    //MARK: - Methods
    func start() {
        let vc = MainViewController(nibName: nil, bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openTabbar(){
        let child = TabbarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}

