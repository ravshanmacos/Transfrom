//
//  BaseCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/07.
//

import UIKit

class BaseCoordinator: Coordinator{
    var navigationController: UINavigationController = UINavigationController()
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    func start() {
        fatalError("Start method should be implemented")
    }
    
    func start(coordinator: Coordinator) {
        childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func removeChildCoordinators() {
        childCoordinators.forEach{$0.removeChildCoordinators()}
        childCoordinators.removeAll()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: {$0 === coordinator}){
            childCoordinators.remove(at: index)
        }
    }
}
