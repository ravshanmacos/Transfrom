//
//  EditWorkoutPartCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/02.
//

import UIKit

class EditWorkoutPartCoordinator: CoordinatorProtocol{
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    private let viewModel: EditWorkoutPartViewModel
    weak var parentCoordinator: UpdateCoordinatorProtocol?
    
    init(presenter: UINavigationController, workoutPart: WorkoutPart) {
        self.navigationController = presenter
        self.viewModel = EditWorkoutPartViewModel(workoutPart: workoutPart)
        self.setupPublishers()
    }
    
    func setupPublishers(){
        viewModel.updatedData = {[self] data in
            parentCoordinator?.workoutPartDidUpdate(viewModel.workoutPart, data: data)
        }
    }
    
    func start() {
        let vc = EditWorkoutPartController(nibName: nil, bundle: nil)
        vc.viewModel = viewModel
        navigationController.present(vc, animated: true)
    }
}
