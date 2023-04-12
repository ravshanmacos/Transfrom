//
//  WorkoutCategoryCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit
import Combine

class WorkoutCategoryCoordinator: BaseCoordinator{
    
    //MARK: - Properties
    private var viewModel: WorkoutCategoryViewModel?
    private var cancellables: [AnyCancellable] = []
    
    var coreDataManager: CoreDataManager?

    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        super.init()
        navigationController = presenter
    }
    
    private func setupPublishers(){
        guard let viewModel else {return}
        viewModel.$isNextBtnTapped.sink {[weak self] isTapped in
            guard let self, isTapped else {return}
            self.workoutDidSelect(viewModel.getSelectedWorkout())
        }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    override func start() {
        //setup view model
        viewModel = WorkoutCategoryViewModel()
        viewModel?.coredataManager = coreDataManager
        setupPublishers()
        
        //setup view controller
        let vc = WorkoutCategoryController()
        vc.viewModel = viewModel
        vc.title = "Category"
        navigationController.pushViewController(vc, animated: true)
    }
}

//MARK: - Coordinating
extension WorkoutCategoryCoordinator{
    func workoutDidSelect(_ workout: Workout){
        let child = TimerViewCoordinator()
        child.navigationController = navigationController
        child.coreDataManager = coreDataManager
        child.selectedWorkout = workout
        start(coordinator: child)
    }
}
