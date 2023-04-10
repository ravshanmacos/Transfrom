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
    private let viewModel: CreateWorkoutViewModel
    private var cancellables: [AnyCancellable] = []
    
    //optionals
    var createWorkoutVC:  CreateWorkoutController?
    
    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        self.viewModel = CreateWorkoutViewModel()
        super.init()
        self.navigationController = presenter
        setupPublishers()
    }
    
    private func setupPublishers(){
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
        //initializing view controller
        let vc = CreateWorkoutController(nibName: nil, bundle: nil)
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
        child.coredataHelper = viewModel.coredataHelper
        start(coordinator: child)
    }
    
    func updateWorkout(for workout: Workout){
        let child = UpdateWorkoutCoordinator()
        child.navigationController = navigationController
        child.coredataHelper = viewModel.coredataHelper
        child.workout = workout
        start(coordinator: child)
    }
}


