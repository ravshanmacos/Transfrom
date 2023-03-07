//
//  TabbarCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

class TabbarCoordinator: Coordinator{
    
    private let presenter: UINavigationController
    private var tabbarViewController: TabBarController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let tabbarViewController = TabBarController(nibName: nil, bundle: nil)
        presenter.pushViewController(tabbarViewController, animated: true)
        self.tabbarViewController = tabbarViewController
    }
    
}
