//
//  MainCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit
import Combine

class IntroViewCoordinator: BaseCoordinator{
    
    //MARK: - Properties
    private let viewModel: IntroViewModel
    private var cancellables: [AnyCancellable] = []
    
    //MARK: - Lifecycle
    override init() {
        self.viewModel = IntroViewModel()
        super.init()
        setupPublishers()
    }
    
    private func setupPublishers(){
        viewModel.$isNextBtnTapped.sink {[weak self] isTapped in
            guard let self else {return}
            if isTapped{
                self.showTabbar()
            }
        }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    override func start() {
        let vc = IntroViewController(nibName: nil, bundle: nil)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}

//MARK: - Coordinating
extension IntroViewCoordinator{
    func showTabbar(){
        let child = TabbarCoordinator()
        child.navigationController = navigationController
        start(coordinator: child)
    }
}

