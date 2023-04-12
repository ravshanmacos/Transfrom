//
//  StartWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/14.
//

import UIKit
import Combine

class TimerViewCoordinator: BaseCoordinator{
    //MARK: - Properties
    
    private var cancellables: [AnyCancellable] = []
    private var viewModel:TimerViewModel?
    var coreDataManager: CoreDataManager?
    var selectedWorkout: Workout?
    
    private func setupPublishers(){
        guard let viewModel else { return }
        viewModel.$isUpdatingDidFinish.sink {[weak self] value in
            guard let self else { return }
            if value{
                self.navigationController.popToRootViewController(animated: true)
            }
        }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    override func start() {
        //setup view model
        let viewModel = TimerViewModel()
        viewModel.coreDataManager = coreDataManager
        viewModel.workout = selectedWorkout
        self.viewModel = viewModel
        setupPublishers()
        
        //setup view controller
        let vc = TimerViewController()
        vc.viewModel = viewModel
        vc.title = "Start"
        vc.selectedWorkout = selectedWorkout
        navigationController.pushViewController(vc, animated: true)
    }
}
