//
//  WorkoutProgressCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit
import Combine

class WorkoutProgressCoordinator: BaseCoordinator{
    //MARK: - Properties
    private let viewModel: ProgressTableviewViewModel
    private var cancellables: [AnyCancellable] = []
    
    //MARK: - LifeCycle
    init(presenter: UINavigationController) {
        viewModel = ProgressTableviewViewModel()
        super.init()
        self.navigationController = presenter
        setubPublishers()
    }
    
    private func setubPublishers(){
        viewModel.$workout.dropFirst(1).sink {[weak self] value in
            guard let self, let value else {return}
            self.workoutTypeDidSelect(value)
        }.store(in: &cancellables)
    }
    
   //MARK: - Actions
    override func start() {
        let vc = ProgressTableViewController(nibName: nil, bundle: nil)
        vc.title = "Progress"
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: - Coordinating
extension WorkoutProgressCoordinator{
    private func workoutTypeDidSelect(_ workout: Workout){
        let child = AnalysisCoordinator()
        child.navigationController = navigationController
        child.coredataHelper = viewModel.getCoreDataHelper()
        child.workout = workout
        start(coordinator: child)
    }
}
