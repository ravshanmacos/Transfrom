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
    private var viewModel: ProgressTableviewViewModel?
    private var cancellables: [AnyCancellable] = []
    
    var coreDataManager: CoreDataManager?
    
    //MARK: - LifeCycle
    init(presenter: UINavigationController) {
        super.init()
        self.navigationController = presenter
        
    }
    
    private func setubPublishers(){
        guard let viewModel else { return }
        viewModel.$workout.dropFirst(1).sink {[weak self] value in
            guard let self, let value else {return}
            self.workoutTypeDidSelect(value)
        }.store(in: &cancellables)
    }
    
   //MARK: - Actions
    override func start() {
        //setup view model
        let viewModel = ProgressTableviewViewModel()
        viewModel.coreDataManager = coreDataManager
        self.viewModel = viewModel
        setubPublishers()
        
        //setup view controller
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
        child.coreDataManager = coreDataManager
        child.workout = workout
        start(coordinator: child)
    }
}
