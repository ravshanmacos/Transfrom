//
//  MainCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

class MainCoordinator: Coordinator{
    
    //MARK: - Properties
    private let presenter: UINavigationController
    private var mainViewController: MainViewController?
    private var tabbarCoordinator: TabbarCoordinator?
    
    //MARK: - Lifecycle
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    //MARK: - Methods
    func start() {
        let mainViewController = MainViewController(nibName: nil, bundle: nil)
        mainViewController.title = "Main"
        presenter.pushViewController(mainViewController, animated: true)
        self.mainViewController = mainViewController
        setObserving()
    }
    
    deinit{
        print("de init")
    }

}

extension MainCoordinator{
    private func setObserving(){
        guard mainViewController != nil else{return}
        mainViewController!.isTapped = {[weak self] in
            let tabbarVC = TabBarController(nibName: nil, bundle: nil)
            self?.presenter.pushViewController(tabbarVC, animated: true)
        }
    }
}
