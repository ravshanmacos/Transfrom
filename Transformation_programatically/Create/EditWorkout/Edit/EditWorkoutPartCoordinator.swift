//
//  EditWorkoutPartCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/02.
//

import UIKit
import Combine

class EditWorkoutPartCoordinator: BaseCoordinator{
    private var cancellables: [AnyCancellable] = []
    private var viewModel: EditWorkoutPartViewModel?
    var workoutPart: WorkoutPart?
    
    func setupPublishers(){
        guard let viewModel, let workoutPart else { return }
        viewModel.$isDataUpdated.dropFirst(1).sink {[weak self] data in
            guard let self else { return }
            (parentCoordinator as! UpdateBasedCoordinator).workoutPartDidUpdate(workoutPart, data: data)
        }.store(in: &cancellables)
    }
    
    override func start() {
        guard let workoutPart else { return }
        let viewModel = EditWorkoutPartViewModel()
        viewModel.workoutPart = workoutPart
        self.viewModel = viewModel
        self.setupPublishers()
        
        let vc = EditWorkoutPartController()
        vc.viewModel = viewModel
        navigationController.present(vc, animated: true)
    }
    
    
}
