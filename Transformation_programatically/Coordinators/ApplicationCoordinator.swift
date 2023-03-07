//
//  ApplicationCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

class ApplicationCoordinator: Coordinator{
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let mainCoordinator: MainCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        mainCoordinator = MainCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        mainCoordinator.start()
        window.makeKeyAndVisible()
    }
}
