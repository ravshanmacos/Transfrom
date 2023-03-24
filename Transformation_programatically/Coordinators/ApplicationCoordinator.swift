//
//  ApplicationCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

class ApplicationCoordinator: Coordinator{
    //MARK: - Properties
    //required
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //private
    private let window: UIWindow
    private let mainCoordinator: TabbarCoordinator
    
    //MARK: - LifeCycle
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        //mainCoordinator = MainCoordinator(presenter: navigationController)
        mainCoordinator = TabbarCoordinator(navigationController: navigationController)
    }
    
    //MARK: - Actions
    func start() {
        window.rootViewController = navigationController
        mainCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    
}
