//
//  StartWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/14.
//

import UIKit

class TimerViewCoordinator: BaseCoordinator{
    //MARK: - Properties
    var coredataHelper: CoreDataHelper?
    var selectedWorkout: Workout?
    
    private lazy var viewModel = {
       let viewModel = TimerViewModel(workoutParts: configureWorkout())
        viewModel.coredataHelper = coredataHelper
        return viewModel
    }()
    
    //MARK: - Actions
    override func start() {
        let vc = TimerViewController()
        vc.viewModel = viewModel
        vc.title = "Start"
        vc.selectedWorkout = selectedWorkout
        navigationController.pushViewController(vc, animated: true)
    }
}

extension TimerViewCoordinator{
    private func configureWorkout()-> [WorkoutPart]{
        var workoutParts: [WorkoutPart] = []
        guard let selectedWorkout, let workoutPartsSet = selectedWorkout.workoutParts else{return workoutParts}
        workoutPartsSet.forEach({ el in
            let workoutPart = el as! WorkoutPart
            workoutParts.append(workoutPart)
        })
        return workoutParts
    }
}
