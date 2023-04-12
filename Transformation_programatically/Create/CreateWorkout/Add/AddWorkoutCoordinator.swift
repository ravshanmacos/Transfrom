//
//  AddWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import Foundation

import UIKit
import CoreData
import Combine

class AddWorkoutCoordinator: BaseCoordinator{
    
    //MARK: - Properties
    private var cancellables: [AnyCancellable] = []
    private var viewModel: AddWorkoutViewModel?
    var coreDataManager: CoreDataManager?
    var addWorkoutVC: AddWorkoutController?
    
    
    private func setupPublishers(){
        guard let viewModel else {return}
        viewModel.$workout.sink {[weak self] workout in
            guard let self, let workout else {return}
            self.workoutDidCreate(workout)
        }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    override func start() {
        //setup view model
        let viewModel = AddWorkoutViewModel()
        viewModel.coreDataManager = coreDataManager
        self.viewModel = viewModel
        setupPublishers()
        
        //setup view controller
        let vc = AddWorkoutController()
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
        self.addWorkoutVC = vc
    }
}

//MARK: - Coordinating

extension AddWorkoutCoordinator{
    func workoutDidCreate(_ workout: Workout){
        let child = UpdateWorkoutPartsCoordinator()
        child.navigationController = navigationController
        child.workout = workout
        child.coreDataManager = coreDataManager
        start(coordinator: child)
    }
}


