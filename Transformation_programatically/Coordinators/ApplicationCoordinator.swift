//
//  ApplicationCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

class ApplicationCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let window: UIWindow
    private let mainCoordinator: TabbarCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        //mainCoordinator = MainCoordinator(presenter: navigationController)
        mainCoordinator = TabbarCoordinator(navigationController: navigationController)
    }
    
    func start() {
        window.rootViewController = navigationController
        mainCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    
}
