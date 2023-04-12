//
//  EditWorkoutPartsCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/15.
//

import UIKit
import Combine

class UpdateWorkoutPartsCoordinator: UpdateBasedCoordinator{
    
    //MARK: - Properties
    private var cancellables: [ AnyCancellable] = []
    private var viewModel: UpdateWorkoutPartsViewModel?
    private var updateWorkoutPartsVC: UpdateWorkoutPartsController?
    var coreDataManager: CoreDataManager?
    var workout: Workout?
    
    private func setupPublishers(){
        guard let viewModel else { return }
        viewModel.$selectedWorkoutPart.sink {[weak self] workoutPart in
            guard let self, let workoutPart else { return }
            self.showEditWorkoutPart(workoutPart)
        }.store(in: &cancellables)
        
        viewModel.$isWorkoutUpdateDidFinish.sink {[weak self] value in
            guard let self else { return }
            if value{
                navigationController.popToRootViewController(animated: true)
            }
        }.store(in: &cancellables)
    }
    
   //MARK: - Actions
    override func start() {
        //setup ViewModel
        let viewModel = UpdateWorkoutPartsViewModel()
        viewModel.coreDataManager = coreDataManager
        viewModel.workout = workout
        self.viewModel = viewModel
        self.setupPublishers()
        
        //setup view controller
        let vc = UpdateWorkoutPartsController()
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
        self.updateWorkoutPartsVC = vc
    }
    
    override func workoutPartDidUpdate(_ workoutPart: WorkoutPart, data: [String:Any]){
        guard let updateWorkoutPartsVC else{return}
        updateWorkoutPartsVC.updateWorkoutParts(with: workoutPart, data: data)
        navigationController.dismiss(animated: true)
    }
}

//MARK: - Coordinating
extension UpdateWorkoutPartsCoordinator{
    func showEditWorkoutPart(_ workoutPart: WorkoutPart){
        let child = EditWorkoutPartCoordinator()
        child.navigationController = navigationController
        child.workoutPart = workoutPart
        start(coordinator: child)
    }
}
