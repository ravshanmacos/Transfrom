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
    private let viewModel: WorkoutCategoryViewModel
    private var cancellables: [AnyCancellable] = []

    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        viewModel = WorkoutCategoryViewModel()
        super.init()
        navigationController = presenter
        setupPublishers()
    }
    
    private func setupPublishers(){
        viewModel.$isNextBtnTapped.sink {[weak self] isTapped in
            guard let self, isTapped else {return}
            self.workoutDidSelect(self.viewModel.getSelectedWorkout())
        }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    override func start() {
        //init
        let vc = WorkoutCategoryController()
        vc.viewModel = viewModel
        vc.title = "Category"
        navigationController.pushViewController(vc, animated: true)
    }
    deinit {
        print("deinit")
    }
}

//MARK: - Coordinating
extension WorkoutCategoryCoordinator{
    func workoutDidSelect(_ workout: Workout){
        let child = TimerViewCoordinator()
        child.navigationController = navigationController
        child.coredataHelper = viewModel.getCoreDataHelper()
        child.selectedWorkout = workout
        start(coordinator: child)
    }
}
