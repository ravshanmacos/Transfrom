//
//  UpdateWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import UIKit
import Combine

class UpdateWorkoutCoordinator: UpdateBasedCoordinator{
    //MARK: - Properties
    //required
    private var cancellables: [AnyCancellable] = []
    private var viewModel: UpdateWorkoutViewModel?
    private var updateWorkoutVC: UpdateWorkoutController?
    var coreDataManager: CoreDataManager?
    var workout: Workout?
    
    func setupPublishers(){
        guard let viewModel else { return }
        viewModel.$workoutPart.dropFirst(1).sink {[weak self] value in
            guard let self else { return }
            if let value{
                self.showEditWorkoutPart(value)
            }
        }.store(in: &cancellables)
        
        viewModel.$isAddWorkoutTapped.dropFirst(1)
            .sink {[weak self] value in
                guard let self else {return}
                if value {
                    self.navigationController.popToRootViewController(animated: true)
                }
            }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    override func start() {
        
        //initializing View Model
        guard let workout, let coreDataManager else { return }
        let viewModel = UpdateWorkoutViewModel(workout, coredataManager: coreDataManager)
        self.viewModel = viewModel
        setupPublishers()
        
        
        //initializing view Controller
        let vc = UpdateWorkoutController()
        vc.title = "Update"
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
        self.updateWorkoutVC = vc
    }
    
    func showEditWorkoutPart(_ workoutPart: WorkoutPart){
        let child = EditWorkoutPartCoordinator()
        child.navigationController = navigationController
        child.workoutPart = workoutPart
        start(coordinator: child)
    }
    
    override func workoutPartDidUpdate(_ workoutPart: WorkoutPart, data: [String:Any]) {
        guard let updateWorkoutVC else{return}
        updateWorkoutVC.updateWorkoutParts(with: workoutPart, data: data)
        navigationController.dismiss(animated: true)
    }
}



