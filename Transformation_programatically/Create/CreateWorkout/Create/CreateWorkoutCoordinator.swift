//
//  CreateWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit
import Combine

class CreateWorkoutCoordinator: BaseCoordinator{
    
    //MARK: - Properties
    private var viewModel: CreateWorkoutViewModel?
    private var cancellables: [AnyCancellable] = []
    
    //optionals
    private var createWorkoutVC:  CreateWorkoutController?
    var coreDataManager: CoreDataManager?
    
    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        super.init()
        self.navigationController = presenter
    }
    
    private func setupPublishers(){
        guard let viewModel else {return}
        viewModel.$workout.dropFirst(1).sink {[weak self] value in
            guard let self, let value else {return}
            self.updateWorkout(for: value)
        }.store(in: &cancellables)
        
        viewModel.$isAddTapped.dropFirst(1).sink {[weak self] value in
            guard let self else {return}
            if value {
                self.addWorkout()
            }
        }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    override func start() {
        guard let coreDataManager else {return}
        //setup view model
        let viewModel = CreateWorkoutViewModel(coreDataManager)
        self.viewModel = viewModel
        setupPublishers()
        
        //setup view controller
        let vc = CreateWorkoutController()
        vc.title = "Workouts"
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
        self.createWorkoutVC = vc
    }
    
    func onSaveTap(){
        guard let createWorkoutVC else{return}
        navigationController.popToViewController(createWorkoutVC, animated: true)
    }
}

//MARK: - Coordinating
extension CreateWorkoutCoordinator{
    func addWorkout(){
        let child = AddWorkoutCoordinator()
        child.navigationController = navigationController
        child.coreDataManager = coreDataManager
        start(coordinator: child)
    }
    
    func updateWorkout(for workout: Workout){
        let child = UpdateWorkoutCoordinator()
        child.navigationController = navigationController
        child.coreDataManager = coreDataManager
        child.workout = workout
        start(coordinator: child)
    }
}


