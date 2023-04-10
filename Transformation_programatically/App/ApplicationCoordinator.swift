//
//  ApplicationCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator{
    //MARK: - Properties
    //private
    private let window: UIWindow
    
    //MARK: - LifeCycle
    init(window: UIWindow) {
        self.window = window
    }
    
    //MARK: - Actions
    override func start() {
        let introViewCoordinator = IntroViewCoordinator()
        window.rootViewController = introViewCoordinator.navigationController
        start(coordinator: introViewCoordinator)
        window.makeKeyAndVisible()
    }
    
    
}
