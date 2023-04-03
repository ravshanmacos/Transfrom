//
//  MainCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit
import Combine

class MainCoordinator: CoordinatorProtocol{
    
    //MARK: - Properties
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    //MARK: - Lifecycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    //MARK: - Actions
    func start() {
        let vc = MainViewController(nibName: nil, bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

//MARK: - Coordinating
extension MainCoordinator{
    func openTabbar(){
        let child = TabbarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}

