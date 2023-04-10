//
//  Coordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

protocol Coordinator: AnyObject{
    var navigationController: UINavigationController {get set}
    var parentCoordinator: Coordinator? {get set}
     
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}

protocol CoordinatorProtocol: AnyObject{
    var navigationController: UINavigationController {get set}
    var childCoordinators: [CoordinatorProtocol] {get set}
     
    func start()
}
